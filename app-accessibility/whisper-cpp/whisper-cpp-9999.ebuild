# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..15} )
ROCM_VERSION=7.2  # controls AMDGPU_TARGETS
ROCM_MIN_VERSION=6.1  # src/ggml-hip/CMakeList.txt

inherit cmake cuda flag-o-matic python-any-r1 rocm toolchain-funcs

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

# GGML BLAS backends
BLAS_BACKENDS="blis openblas"

GGML_IUSE="blas flexiblas ${BLAS_BACKENDS} ${CPU_FLAGS[*]} cuda opencl openmp rocm vulkan"

IUSE="${GGML_IUSE} ffmpeg sdl2 test"
REQUIRED_USE="
	blas? ( ?? ( ${BLAS_BACKENDS} ) )
	rocm? ( ${ROCM_REQUIRED_USE} )
"

unset BLAS_BACKENDS GGML_IUSE X86_CPU_FLAGS CPU_FLAGS

RESTRICT="!test? ( test )"

COMMON_DEPEND="
	blas? (
		virtual/blas[flexiblas=]
		flexiblas? ( sci-libs/flexiblas:=[blis?,openblas?,openmp?] )
		!flexiblas? (
			blis? ( sci-libs/blis:=[openmp?] )
			openblas? ( sci-libs/openblas:=[openmp?] )
		)
	)
	rocm? (
		>=dev-util/hip-${ROCM_MIN_VERSION}:=
		>=sci-libs/hipBLAS-${ROCM_MIN_VERSION}:=
		>=sci-libs/rocBLAS-${ROCM_MIN_VERSION}:=
	)
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	ffmpeg? ( media-video/ffmpeg:= )
	sdl2? (
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
BDEPEND="
	opencl? ( ${PYTHON_DEPS} )
	vulkan? ( media-libs/shaderc )
"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	if use opencl; then
		python-any-r1_pkg_setup
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
		-DWHISPER_USE_SYSTEM_LLAMA=OFF # Requires system GGML $(usex sdl2)
		-DWHISPER_BUILD_TESTS=$(usex test)
		-DWHISPER_BUILD_EXAMPLES=ON
		-DWHISPER_SDL2=$(usex sdl2)
		-DWHISPER_COMMON_FFMPEG=$(usex ffmpeg)

		# avoid clashing with sci-ml/ggml
		-DCMAKE_INSTALL_INCLUDEDIR="include/${MY_PN}"
		-DCMAKE_INSTALL_LIBDIR="$(get_libdir)/${MY_PN}"
		-DCMAKE_INSTALL_RPATH="\$ORIGIN/../$(get_libdir)/${MY_PN};\$ORIGIN"
	)

	# GGML backends
	mycmakeargs+=(
		-DGGML_NATIVE=OFF	# don't set march
		-DGGML_CCACHE=OFF
		-DGGML_LTO="$(tc-is-lto)"

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

		-DGGML_BLAS=$(usex blas)
		-DGGML_CUDA=$(usex cuda)
		-DGGML_HIP=$(usex rocm)
		-DGGML_VULKAN=$(usex vulkan)
		-DGGML_OPENMP=$(usex openmp)
		-DGGML_RPC=ON
		-DGGML_OPENCL=$(usex opencl)
	)

	if use blas; then
		if use flexiblas ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="FlexiBLAS"
			)
		elif use blis ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="FLAME"
			)
		elif use openblas ; then
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR="OpenBLAS"
			)
		else
			mycmakeargs+=(
				-DGGML_BLAS_VENDOR=Generic
				# https://cmake.org/cmake/help/latest/module/FindBLAS.html
				-DBLA_PREFER_PKGCONFIG=ON
				-DBLA_PKGCONFIG_BLAS=cblas
			)
		fi
	fi

	if use cuda; then
		local -x CUDAHOSTCXX="$(cuda_gccdir)"
		# tries to recreate dev symlinks
		cuda_add_sandbox
		addpredict "/dev/char/"
	fi

	if use rocm; then
		# Changing compiler with rocm_use_{hipcc,clang} is not necessary
		# Pass HIP compatible flags using dedicated CMake variables
		mycmakeargs+=(
			-DGPU_TARGETS=$(get_amdgpu_flags)
			-DCMAKE_HIP_FLAGS="$(test-flags-HIPCXX ${CXXFLAGS})"
			# cmake.eclass clears per-build-type flags for C/CXX only; drop CMake's "-O2 -g -DNDEBUG" for HIP
			-DCMAKE_HIP_FLAGS_${CMAKE_BUILD_TYPE^^}=
		)
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	newinitd "${FILESDIR}/${PN}.init" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
}
