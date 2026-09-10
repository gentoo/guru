# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="7.1"

inherit cmake cuda rocm linux-info toolchain-funcs

TINY_LLAMAS_COMMIT="99dd1a73db5a37100bd4ae633f4cfce6560e1567"

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggml-org/llama.cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ggml-org/llama.cpp.git"
	LLAMA_BUILD_IS_DEV=ON
	LLAMA_BUILD_NUMBER="b0000"
	LLAMA_UI_VERSION="b10809"
	MY_PV="${PV}"
else
	if [[ $(ver_cut 4) == "p" ]]; then
		LLAMA_BUILD_IS_DEV=ON
		LLAMA_BUILD_NUMBER="b$(ver_cut 5)"
		MY_PV="${LLAMA_BUILD_NUMBER}"
		S="${WORKDIR}/llama.cpp-${MY_PV}"
	else
		LLAMA_BUILD_IS_DEV=OFF
		# Set from https://github.com/ggml-org/llama.cpp/releases/download/v${PV}/nightly-tag.txt
		LLAMA_BUILD_NUMBER="b10809"
		MY_PV="v${PV}"
		S="${WORKDIR}/llama.cpp-${PV}"
	fi
	LLAMA_UI_VERSION="${LLAMA_BUILD_NUMBER}"
	SRC_URI="https://github.com/ggml-org/llama.cpp/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SRC_URI+="
	https://github.com/ggml-org/llama.cpp/releases/download/${LLAMA_UI_VERSION}/llama-${LLAMA_UI_VERSION}-ui.tar.gz
	examples? (
		https://huggingface.co/ggml-org/tiny-llamas/resolve/${TINY_LLAMAS_COMMIT}/stories15M-q4_0.gguf
			-> ggml-org_models_tinyllamas_stories15M-q4_0-${TINY_LLAMAS_COMMIT}.gguf
	)
"

LICENSE="MIT"
SLOT="0"
X86_CPU_FLAGS=(
	amx_bf16
	amx_int8
	amx_tile
	avx
	avx2
	avx512_bf16
	avx512_vnni
	avx512f
	avx512vbmi
	avx_vnni
	bmi2
	f16c
	fma3
	sse4_2
)
CPU_FLAGS=( "${X86_CPU_FLAGS[@]/#/cpu_flags_x86_}" )

# wwma USE explained here: https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md#hip
IUSE="${CPU_FLAGS[*]} curl openblas +openmp blis rocm cuda opencl openssl vulkan flexiblas wmma examples"

REQUIRED_USE="
	?? (
		openblas
		blis
		flexiblas
	)
	rocm? ( ${ROCM_REQUIRED_USE} )
	wmma? (
		rocm
	)
"

# curl is needed for pulling models from huggingface
# numpy is used by convert_hf_to_gguf.py
CDEPEND="
	curl? ( net-misc/curl:= )
	openblas? ( sci-libs/openblas:= )
	openmp? ( llvm-runtimes/openmp:= )
	blis? ( sci-libs/blis:= )
	flexiblas? ( sci-libs/flexiblas:= )
	rocm? (
		>=dev-util/hip-${ROCM_VERSION}:=
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=[${ROCM_USEDEP}]
		wmma? (
			>=sci-libs/rocWMMA-${ROCM_VERSION}:=[${ROCM_USEDEP}]
		)
	)
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	openssl? ( dev-libs/openssl:= )
"
DEPEND="${CDEPEND}
	opencl? ( dev-util/opencl-headers )
	vulkan? (
		dev-util/spirv-headers
		dev-util/vulkan-headers
	)
"
RDEPEND="${CDEPEND}
	dev-python/numpy
	opencl? ( dev-libs/opencl-icd-loader )
	vulkan? ( media-libs/vulkan-loader )
"
BDEPEND="media-libs/shaderc"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
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

	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_unpack() {
	[[ ${PV} == *9999* ]] && git-r3_src_unpack
	default
}

src_prepare() {
	use cuda && cuda_src_prepare
	cmake_src_prepare
	if use examples; then
		mkdir -p "${BUILD_DIR}/tinyllamas" || die
		cp "${DISTDIR}/ggml-org_models_tinyllamas_stories15M-q4_0-${TINY_LLAMAS_COMMIT}.gguf" \
			"${BUILD_DIR}/tinyllamas/stories15M-q4_0.gguf" || die
	fi

	# Move web UI assets where they belong, bug #979245
	mkdir -p "${S}"/tools/ui || die
	cp -a "${WORKDIR}"/llama-${LLAMA_UI_VERSION} "${S}"/tools/ui/dist || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
		-DLLAMA_BUILD_IS_DEV=${LLAMA_BUILD_IS_DEV}
		-DLLAMA_BUILD_TESTS=OFF
		-DLLAMA_BUILD_EXAMPLES=$(usex examples)
		-DLLAMA_BUILD_SERVER=ON
		-DBUILD_NUMBER="${LLAMA_BUILD_NUMBER}"
		-DLLAMA_CURL=$(usex curl)
		-DLLAMA_OPENSSL=$(usex openssl)
		-DGENTOO_REMOVE_CMAKE_BLAS_HACK=ON

		# avoid clashing with whisper.cpp
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)/llama.cpp"
		-DCMAKE_INSTALL_RPATH="${EPREFIX}/usr/$(get_libdir)/llama.cpp"
	)

	# GGML backends
	mycmakeargs+=(
		-DGGML_NATIVE=OFF	# don't set march

		# CPU Flags
		-DGGML_SSE42=$(usex cpu_flags_x86_sse4_2)
		-DGGML_AVX=$(usex cpu_flags_x86_avx)
		-DGGML_AVX_VNNI=$(usex cpu_flags_x86_avx_vnni)
		-DGGML_AVX2=$(usex cpu_flags_x86_avx2)
		-DGGML_BMI2=$(usex cpu_flags_x86_bmi2)
		-DGGML_AVX512=$(usex cpu_flags_x86_avx512f)
		-DGGML_AVX512_VBMI=$(usex cpu_flags_x86_avx512vbmi)
		-DGGML_AVX512_VNNI=$(usex cpu_flags_x86_avx512_vnni)
		-DGGML_AVX512_BF16=$(usex cpu_flags_x86_avx512_bf16)
		-DGGML_FMA=$(usex cpu_flags_x86_fma3)
		-DGGML_F16C=$(usex cpu_flags_x86_f16c)
		-DGGML_AMX_TILE=$(usex cpu_flags_x86_amx_tile)
		-DGGML_AMX_INT8=$(usex cpu_flags_x86_amx_int8)
		-DGGML_AMX_BF16=$(usex cpu_flags_x86_amx_bf16)

		-DGGML_CUDA=$(usex cuda)
		-DGGML_VULKAN=$(usex vulkan)
		-DGGML_OPENMP=$(usex openmp)
		-DGGML_RPC=ON
		-DGGML_OPENCL=$(usex opencl)
	)

	if use openblas ; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
		)
	fi

	if use blis ; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=FLAME
		)
	fi

	if use flexiblas; then
		mycmakeargs+=(
			-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=FlexiBLAS
		)
	fi

	if use cuda; then
		local -x CUDAHOSTCXX="$(cuda_gccdir)"
		# tries to recreate dev symlinks
		cuda_add_sandbox
		addpredict "/dev/char/"
	fi

	if use rocm; then
		rocm_use_hipcc
		mycmakeargs+=(
			-DGGML_HIP=ON
			-DAMDGPU_TARGETS=$(get_amdgpu_flags)
			-DGGML_HIP_ROCWMMA_FATTN=$(usex wmma)
		)
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	dobin "${BUILD_DIR}/bin/ggml-rpc-server"

	# avoid clashing with whisper.cpp
	rm -r "${ED}/usr/include" || die
}
