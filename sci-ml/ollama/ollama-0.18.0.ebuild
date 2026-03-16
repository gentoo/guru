# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# supports ROCM/HIP >=5.5, but we define 6.1 due to the eclass
ROCM_VERSION="6.1"
inherit cuda rocm
inherit cmake
inherit flag-o-matic go-module linux-info systemd toolchain-funcs

DESCRIPTION="Get up and running with Llama 3, Mistral, Gemma, and other language models."
HOMEPAGE="https://ollama.com"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ollama/ollama.git"
else
	MY_PV="${PV/_rc/-rc}"
	MY_P="${PN}-${MY_PV}"
	SRC_URI="
		https://github.com/ollama/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${MY_P}.gh.tar.gz
		https://github.com/gentoo-golang-dist/${PN}/releases/download/v${MY_PV}/${MY_P}-deps.tar.xz
	"
	if [[ ${PV} != *_rc* ]]; then
		KEYWORDS="~amd64"
	fi
fi

LICENSE="MIT"
SLOT="0"

IUSE="cuda rocm vulkan"
# IUSE+=" opencl"

BLAS_BACKENDS="blis mkl openblas"
BLAS_REQUIRED_USE="blas? ( ?? ( ${BLAS_BACKENDS} ) )"

IUSE+=" blas flexiblas ${BLAS_BACKENDS}"
REQUIRED_USE+=" ${BLAS_REQUIRED_USE}"

declare -rgA CPU_FEATURES=(
	[AVX2]="x86"
	[AVX512F]="x86"
	[AVX512_VBMI]="x86;avx512vbmi"
	[AVX512_VNNI]="x86"
	[AVX]="x86"
	[AVX_VNNI]="x86"
	[BMI2]="x86"
	[F16C]="x86"
	[FMA]="x86;fma3"
	[SSE42]="x86;sse4_2"
)
add_cpu_features_use() {
	for flag in "${!CPU_FEATURES[@]}"; do
		IFS=$';' read -r arch use <<< "${CPU_FEATURES[${flag}]}"
		IUSE+=" cpu_flags_${arch}_${use:-${flag,,}}"
	done
}
add_cpu_features_use

RESTRICT="mirror test"

# FindBLAS.cmake
# If Fortran is an enabled compiler it sets BLAS_mkl_THREADING to gnu. -> sci-libs/mkl[gnu-openmp]
# If Fortran is not an enabled compiler it sets BLAS_mkl_THREADING to intel. -> sci-libs/mkl[llvm-openmp]
COMMON_DEPEND="
	blas? (
		blis? (
			sci-libs/blis:=
		)
		flexiblas? (
			sci-libs/flexiblas[blis?,mkl?,openblas?]
		)
		mkl? (
			sci-libs/mkl[llvm-openmp]
		)
		openblas? (
			sci-libs/openblas
		)
		virtual/blas[flexiblas=]
	)
	cuda? (
		dev-util/nvidia-cuda-toolkit:=
	)
	rocm? (
		>=dev-util/hip-${ROCM_VERSION}:=
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=
		>=sci-libs/rocBLAS-${ROCM_VERSION}:=
	)
"

DEPEND="
	${COMMON_DEPEND}
	>=dev-lang/go-1.23.4
"
BDEPEND="
	vulkan? (
		dev-util/vulkan-headers
		media-libs/shaderc
	)
"

RDEPEND="
	${COMMON_DEPEND}
	acct-group/${PN}
	>=acct-user/${PN}-3[cuda?]
"

PATCHES=(
	"${FILESDIR}/${PN}-9999-use-GNUInstallDirs.patch"
	"${FILESDIR}/${PN}-0.18.0-make-installing-runtime-deps-optional.patch"
)

pkg_pretend() {
	if use amd64; then
		if use cpu_flags_x86_f16c && use cpu_flags_x86_avx2 && use cpu_flags_x86_fma3 && ! use cpu_flags_x86_bmi2; then
			ewarn
			ewarn "CPU_FLAGS_X86: bmi2 not enabled."
			ewarn "  Not building haswell runner."
			ewarn "  Not building skylakex runner."
			ewarn "  Not building icelake runner."
			ewarn "  Not building alderlake runner."
			ewarn
			if grep bmi2 /proc/cpuinfo > /dev/null; then
				ewarn "bmi2 found in /proc/cpuinfo"
				ewarn
			fi
		fi
	fi
}

pkg_setup() {
	if use rocm; then
		linux-info_pkg_setup
		if linux-info_get_any_version && linux_config_exists; then
			if ! linux_chkconfig_present HSA_AMD_SVM; then
				ewarn "To use ROCm/HIP, you need to have HSA_AMD_SVM option enabled in your kernel."
			fi
		fi
	fi
}

src_unpack() {
	# Already filter lto flags for ROCM
	# 963401
	if use rocm; then
		# copied from _rocm_strip_unsupported_flags
		strip-unsupported-flags
		export CXXFLAGS="$(test-flags-HIPCXX "${CXXFLAGS}")"
	fi

	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_prepare() {
	cmake_src_prepare

	sed \
		-e "/set(GGML_CCACHE/s/ON/OFF/g" \
		-i CMakeLists.txt || die "Disable CCACHE sed failed"

	# TODO see src_unpack?
	sed \
		-e "s/ -O3//g" \
		-i \
			ml/backend/ggml/ggml/src/ggml-cpu/cpu.go \
		|| die "-O3 sed failed"

	# grep -Rl -e 'lib/ollama' -e '"..", "lib"'  --include '*.go'
	sed \
		-e "s/\"..\", \"lib\"/\"..\", \"$(get_libdir)\"/" \
		-e "s#\"lib/ollama\"#\"$(get_libdir)/ollama\"#" \
		-i \
			ml/backend/ggml/ggml/src/ggml.go \
			ml/path.go \
		|| die "libdir sed failed"

	if use amd64; then
		if
			! use cpu_flags_x86_sse4_2; then
			sed -e "/ggml_add_cpu_backend_variant(sse42/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# SSE42)
		fi
		if
			! use cpu_flags_x86_sse4_2 ||
			! use cpu_flags_x86_avx; then
			sed -e "/ggml_add_cpu_backend_variant(sandybridge/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# SSE42 AVX)
		fi
		if
			! use cpu_flags_x86_sse4_2 ||
			! use cpu_flags_x86_avx ||
			! use cpu_flags_x86_f16c ||
			! use cpu_flags_x86_avx2 ||
			! use cpu_flags_x86_bmi2 ||
			! use cpu_flags_x86_fma3; then
			sed -e "/ggml_add_cpu_backend_variant(haswell/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# SSE42 AVX F16C AVX2 BMI2 FMA)
		fi
		if
			! use cpu_flags_x86_sse4_2 ||
			! use cpu_flags_x86_avx ||
			! use cpu_flags_x86_f16c ||
			! use cpu_flags_x86_avx2 ||
			! use cpu_flags_x86_bmi2 ||
			! use cpu_flags_x86_fma3 ||
			! use cpu_flags_x86_avx512f; then
			sed -e "/ggml_add_cpu_backend_variant(skylakex/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt ||  die
			# SSE42 AVX F16C AVX2 BMI2 FMA AVX512)
		fi
		if
			! use cpu_flags_x86_sse4_2 ||
			! use cpu_flags_x86_avx ||
			! use cpu_flags_x86_f16c ||
			! use cpu_flags_x86_avx2 ||
			! use cpu_flags_x86_bmi2 ||
			! use cpu_flags_x86_fma3 ||
			! use cpu_flags_x86_avx512f ||
			! use cpu_flags_x86_avx512vbmi ||
			! use cpu_flags_x86_avx512_vnni; then
			sed -e "/ggml_add_cpu_backend_variant(icelake/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# SSE42 AVX F16C AVX2 BMI2 FMA AVX512 AVX512_VBMI AVX512_VNNI)
		fi
		if
			! use cpu_flags_x86_sse4_2 ||
			! use cpu_flags_x86_avx ||
			! use cpu_flags_x86_f16c ||
			! use cpu_flags_x86_avx2 ||
			! use cpu_flags_x86_bmi2 ||
			! use cpu_flags_x86_fma3 ||
			! use cpu_flags_x86_avx_vnni; then
			sed -e "/ggml_add_cpu_backend_variant(alderlake/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# SSE42 AVX F16C AVX2 BMI2 FMA AVX_VNNI)
		fi

		# ml/backend/ggml/ggml/src/CMakeLists.txt
	fi

	if use cuda; then
		cuda_src_prepare
	fi

	if use rocm; then
		# --hip-version gets appended to the compile flags which isn't a known flag.
		# This causes rocm builds to fail because -Wunused-command-line-argument is turned on.
		# Use nuclear option to fix this.
		# Disable -Werror's from go modules.
		find "${S}" -name ".go" -exec sed -i "s/ -Werror / /g" {} + || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DOLLAMA_INSTALL_RUNTIME_DEPS="no"
		-DGGML_CCACHE="no"

		# backends end up in /usr/bin otherwise
		-DGGML_BACKEND_DL="yes"
		# TODO causes duplicate install warning but breaks detection otherwise ollama/issues/13614
		-DGGML_BACKEND_DIR="${EPREFIX}/usr/$(get_libdir)/${PN}"

		# -DGGML_CPU="yes"
		-DGGML_BLAS="$(usex blas)"

		# -DGGML_CUDA="$(usex cuda)"
		# -DGGML_HIP="$(usex rocm)"

		# -DGGML_METAL="yes" # apple
		# missing from ml/backend/ggml/ggml/src/
		# -DGGML_CANN="yes"
		# -DGGML_MUSA="yes"
		# -DGGML_RPC="yes"
		# -DGGML_SYCL="yes"
		# -DGGML_KOMPUTE="$(usex kompute)"
		# -DGGML_OPENCL="$(usex opencl)"
		# -DGGML_VULKAN="$(usex vulkan)"
		"$(cmake_use_find_package vulkan Vulkan)"
	)

	if tc-is-lto ; then
		mycmakeargs+=(
			-DGGML_LTO="yes"
		)
	fi

	if use blas; then
		if use flexiblas ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="FlexiBLAS"
			)
		elif use blis ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="FLAME"
			)
		elif use mkl ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="Intel10_64lp"
			)
		# elif use nvhpc ; then
		# 	mycmakeargs+=(
		# 		-DGGML_BLAS_VENDOR="NVHPC"
		# 	)
		elif use openblas ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="OpenBLAS"
			)
		else
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="Generic"
			)
		fi
	fi

	if use cuda; then
		local -x CUDAHOSTCXX CUDAHOSTLD
		CUDAHOSTCXX="$(cuda_gccdir)"
		CUDAHOSTLD="$(tc-getCXX)"

		# default to all-major for now until cuda.eclass is updated
		if [[ ! -v CUDAARCHS ]]; then
			local CUDAARCHS="all-major"
		fi

		mycmakeargs+=(
			-DCMAKE_CUDA_ARCHITECTURES="${CUDAARCHS}"
		)

		cuda_add_sandbox -w
		addpredict "/dev/char/"
	else
		mycmakeargs+=(
			-DCMAKE_CUDA_COMPILER="NOTFOUND"
		)
	fi

	if use rocm; then
		mycmakeargs+=(
			-DCMAKE_HIP_ARCHITECTURES="$(get_amdgpu_flags)"
			-DCMAKE_HIP_PLATFORM="amd"
			# ollama doesn't honor the default cmake options
			-DAMDGPU_TARGETS="$(get_amdgpu_flags)"
		)

		local -x HIP_PATH="${ESYSROOT}/usr"
	else
		mycmakeargs+=(
			-DCMAKE_HIP_COMPILER="NOTFOUND"
		)
	fi

	cmake_src_configure
}

src_compile() {
	# export version information
	# https://github.com/gentoo/guru/pull/205
	# https://forums.gentoo.org/viewtopic-p-8831646.html
	local VERSION
	if [[ "${PV}" == *9999* ]]; then
		VERSION="$(
			git describe --tags --first-parent --abbrev=7 --long --dirty --always \
			| sed -e "s/^v//g"
		)"
	else
		VERSION="${PVR}"
	fi
	local EXTRA_GOFLAGS_LD=(
		# "-w" # disable DWARF generation
		# "-s" # disable symbol table
		"-X=github.com/ollama/ollama/version.Version=${VERSION}"
		"-X=github.com/ollama/ollama/server.mode=release"
	)
	GOFLAGS+=" '-ldflags=${EXTRA_GOFLAGS_LD[*]}'"

	ego build

	cmake_src_compile
}

src_install() {
	dobin ollama

	cmake_src_install

	newinitd "${FILESDIR}/ollama.init" "${PN}"
	newconfd "${FILESDIR}/ollama.confd" "${PN}"

	systemd_dounit "${FILESDIR}/ollama.service"
}

pkg_preinst() {
	keepdir /var/log/ollama
	fperms 750 /var/log/ollama
	fowners "${PN}:${PN}" /var/log/ollama
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		einfo "Quick guide:"
		einfo "\tollama serve"
		einfo "\tollama run llama3:70b"
		einfo
		einfo "See available models at https://ollama.com/library"
	fi

	if use cuda ; then
		einfo "When using cuda the user running ${PN} has to be in the video group or it won't detect devices."
		einfo "The ebuild ensures this for user ${PN} via acct-user/${PN}[cuda]"
	fi
}
