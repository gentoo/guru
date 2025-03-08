# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION=6.1
inherit cuda rocm
inherit cmake
inherit go-module systemd toolchain-funcs

DESCRIPTION="Get up and running with Llama 3, Mistral, Gemma, and other language models."
HOMEPAGE="https://ollama.com"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ollama/ollama.git"
else
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

X86_CPU_FLAGS=(
	avx
	f16c
	avx2
	fma3
	avx512f
	avx512vbmi
	avx512_vnni
	avx512_bf16
	avx_vnni
	amx_tile
	amx_int8
)
CPU_FLAGS=("${X86_CPU_FLAGS[@]/#/cpu_flags_x86_}")
IUSE="${CPU_FLAGS[*]} cuda blas mkl rocm"
# IUSE+=" opencl vulkan"

COMMON_DEPEND="
	cuda? (
		dev-util/nvidia-cuda-toolkit:=
	)
	blas? (
		!mkl? (
			virtual/blas
		)
		mkl? (
			sci-libs/mkl
		)
	)
	rocm? (
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=[${ROCM_USEDEP}]
	)
"

DEPEND="
	${COMMON_DEPEND}
	>=dev-lang/go-1.23.4
"

RDEPEND="
	${COMMON_DEPEND}
	acct-group/${PN}
	acct-user/${PN}
"

src_unpack() {
	if [[ "${PV}" == *9999* ]]; then
		git-r3_src_unpack
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_prepare() {
	cmake_src_prepare

	sed -e "/set(GGML_CCACHE/s/ON/OFF/g" -i CMakeLists.txt || die

	if use amd64; then
		if ! use cpu_flags_x86_avx; then
			sed -e "/ggml_add_cpu_backend_variant(sandybridge/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# AVX)
		fi
		if
			! use cpu_flags_x86_avx ||
				! use cpu_flags_x86_f16c ||
				! use cpu_flags_x86_avx2 ||
				! use cpu_flags_x86_fma3
		then
			sed -e "/ggml_add_cpu_backend_variant(haswell/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# AVX F16C AVX2 FMA)
		fi
		if
			! use cpu_flags_x86_avx ||
				! use cpu_flags_x86_f16c ||
				! use cpu_flags_x86_avx2 ||
				! use cpu_flags_x86_fma3 ||
				! use cpu_flags_x86_avx512f
		then
			sed -e "/ggml_add_cpu_backend_variant(skylakex/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# AVX F16C AVX2 FMA AVX512)
		fi
		if
			! use cpu_flags_x86_avx ||
				! use cpu_flags_x86_f16c ||
				! use cpu_flags_x86_avx2 ||
				! use cpu_flags_x86_fma3 ||
				! use cpu_flags_x86_avx512f ||
				! use cpu_flags_x86_avx512vbmi ||
				! use cpu_flags_x86_avx512_vnni
		then
			sed -e "/ggml_add_cpu_backend_variant(icelake/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# AVX F16C AVX2 FMA AVX512 AVX512_VBMI AVX512_VNNI)
		fi
		if
			! use cpu_flags_x86_avx ||
				! use cpu_flags_x86_f16c ||
				! use cpu_flags_x86_avx2 ||
				! use cpu_flags_x86_fma3 ||
				! use cpu_flags_x86_avx_vnni
		then
			sed -e "/ggml_add_cpu_backend_variant(alderlake/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			# AVX F16C AVX2 FMA AVX_VNNI)
		fi

		if
			! use cpu_flags_x86_avx ||
				! use cpu_flags_x86_f16c ||
				! use cpu_flags_x86_avx2 ||
				! use cpu_flags_x86_fma3 ||
				! use cpu_flags_x86_avx512f ||
				! use cpu_flags_x86_avx512vbmi ||
				! use cpu_flags_x86_avx512_vnni ||
				! use cpu_flags_x86_avx512_bf16 ||
				! use cpu_flags_x86_amx_tile ||
				! use cpu_flags_x86_amx_int8
		then
			sed -e "/ggml_add_cpu_backend_variant(sapphirerapids/s/^/# /g" -i ml/backend/ggml/ggml/src/CMakeLists.txt || die
			#AVX F16C AVX2 FMA AVX512 AVX512_VBMI AVX512_VNNI AVX512_BF16 AMX_TILE AMX_INT8)
		fi
		: # ml/backend/ggml/ggml/src/CMakeLists.txt
	fi

	# default
	# return
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
		-DGGML_CCACHE="no"

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
	)

	if use blas; then
		if use mkl; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="Intel"
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

		cuda_add_sandbox -w
	else
		mycmakeargs+=(
			-DCMAKE_CUDA_COMPILER="NOTFOUND"
		)
	fi

	if use rocm; then
		mycmakeargs+=(
			-DCMAKE_HIP_PLATFORM="amd"
		)
		local -x HIP_ARCHS=$(get_amdgpu_flags)
		local -x HIP_PATH="/usr"

		check_amdgpu
	else
		mycmakeargs+=(
			-DCMAKE_HIP_COMPILER="NOTFOUND"
		)
	fi

	cmake_src_configure

	# if ! use cuda && ! use rocm; then
	# 	# to configure and build only CPU variants
	# 	set -- cmake --preset Default "${mycmakeargs[@]}"
	# fi

	# if use cuda; then
	# 	# to configure and build only CUDA
	# 	set -- cmake --preset CUDA "${mycmakeargs[@]}"
	# fi

	# if use rocm; then
	# 	# to configure and build only ROCm
	# 	set -- cmake --preset ROCm "${mycmakeargs[@]}"
	# fi

	# echo "$@" >&2
	# "$@" || die -n "${*} failed"
}

src_compile() {
	ego build

	cmake_src_compile

	# if ! use cuda && ! use rocm; then
	# 	# to configure and build only CPU variants
	# 	set -- cmake --build --preset Default -j16
	# fi

	# if use cuda; then
	# 	# to configure and build only CUDA
	# 	set -- cmake --build --preset CUDA -j16
	# fi

	# if use rocm; then
	# 	# to configure and build only ROCm
	# 	set -- cmake --build --preset ROCm -j16
	# fi

	# echo "$@" >&2
	# "$@" || die -n "${*} failed"
}

src_install() {
	dobin ollama

	cmake_src_install

	if use cuda; then
		# remove the copied cuda files...
		rm "${ED}/usr/lib/ollama"/cuda_*/libcu*.so* || die
	fi

	doinitd "${FILESDIR}"/ollama.init
	systemd_dounit "${FILESDIR}"/ollama.service
}

pkg_preinst() {
	keepdir /var/log/ollama
	# fowners ollama:ollama /var/log/ollama
	fperms 777 /var/log/ollama
}

pkg_postinst() {
	einfo "Quick guide:"
	einfo "ollama serve"
	einfo "ollama run llama3:70b"
	einfo "See available models at https://ollama.com/library"
}
