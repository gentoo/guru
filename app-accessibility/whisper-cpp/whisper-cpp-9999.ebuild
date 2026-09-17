# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.1"

inherit cmake cuda rocm linux-info toolchain-funcs

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"
WHISPER_CPP_LLAMAS_COMMIT="80da2d8bfee42b0e836fc3a9890373e5defc00a6"

DESCRIPTION="Port of OpenAI's Whisper model in C/C++ "
HOMEPAGE="https://github.com/ggml-org/whisper.cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ggml-org/whisper.cpp"
else
	SRC_URI="https://github.com/ggml-org/whisper.cpp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64"
fi

SRC_URI+="
	test? (
		https://huggingface.co/ggerganov/whisper.cpp/resolve/${WHISPER_CPP_LLAMAS_COMMIT}/ggml-base.en.bin
			-> ggerganov_models_whisper.cpp_ggml-base.en-${WHISPER_CPP_LLAMAS_COMMIT}.bin
	)
"

LICENSE="MIT"
SLOT="0"

# GGML CPU flags
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
GGML_IUSE="${CPU_FLAGS[*]} blis cuda flexiblas openblas opencl +openmp rocm vulkan"
unset X86_CPU_FLAGS CPU_FLAGS

IUSE="${GGML_IUSE} ffmpeg sdl2 test"
unset GGML_IUSE
REQUIRED_USE="
	?? (
		openblas
		blis
		flexiblas
	)
	rocm? ( ${ROCM_REQUIRED_USE} )
"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	openblas? ( sci-libs/openblas:= )
	openmp? ( llvm-runtimes/openmp:= )
	blis? ( sci-libs/blis:= )
	flexiblas? ( sci-libs/flexiblas:= )
	rocm? (
		>=dev-util/hip-${ROCM_VERSION}:=
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=
	)
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	ffmpeg? ( media-video/ffmpeg:= )
	sdl2? (
		>=sci-misc/llama-cpp-0.3.0:=
		media-libs/libsdl2:=
	)
"
DEPEND="${COMMON_DEPEND}
	opencl? ( dev-util/opencl-headers )
	vulkan? (
		dev-util/spirv-headers
		dev-util/vulkan-headers
	)
"
RDEPEND="${COMMON_DEPEND}
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

src_prepare() {
	use cuda && cuda_src_prepare
	cmake_src_prepare
	if use test; then
		cp "${DISTDIR}/ggerganov_models_whisper.cpp_ggml-base.en-${WHISPER_CPP_LLAMAS_COMMIT}.bin" \
			"${S}"/models/ggml-base.en.bin || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DWHISPER_USE_SYSTEM_LLAMA=$(usex sdl2)
		-DWHISPER_BUILD_TESTS=$(usex test)
		-DWHISPER_BUILD_EXAMPLES=ON
		-DWHISPER_FFMPEG=$(usex ffmpeg)
		-DWHISPER_SDL2=$(usex sdl2)

		# avoid clashing with sci-ml/ggml
		-DCMAKE_INSTALL_INCLUDEDIR="include/${MY_PN}"
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)/${MY_PN}"
		-DCMAKE_INSTALL_RPATH="\$ORIGIN/../$(get_libdir)/${MY_PN};\$ORIGIN"
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
		# See ${S}/docs/build.md#hip
		export HIPCXX="$(hipconfig -l)/clang" HIP_PATH="$(hipconfig -p)"
		mycmakeargs+=(
			-DGGML_HIP=ON
			-DGPU_TARGETS=$(get_amdgpu_flags)
		)
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}
