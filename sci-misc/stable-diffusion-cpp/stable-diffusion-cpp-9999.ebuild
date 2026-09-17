# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.1"

inherit cmake cuda rocm linux-info

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Diffusion model(SD,Flux,Wan,Qwen Image,Z-Image,...) inference in pure C/C++"
HOMEPAGE="https://github.com/leejet/stable-diffusion.cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leejet/stable-diffusion.cpp.git"
else
	MY_PV="b${PV#0_pre}"
	SRC_URI="https://github.com/leejet/stable-diffusion.cpp/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64"
fi

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
GGML_IUSE="${CPU_FLAGS[*]} blis cuda flexiblas openblas opencl rocm vulkan"
unset X86_CPU_FLAGS CPU_FLAGS

IUSE="${GGML_IUSE} webm webp"
unset GGML_IUSE
REQUIRED_USE="
	?? (
		openblas
		blis
		flexiblas
	)
	rocm? ( ${ROCM_REQUIRED_USE} )
	webm? (
		webp
	)
	wmma? (
		rocm
	)
"

COMMON_DEPEND="
	openblas? ( sci-libs/openblas:= )
	blis? ( sci-libs/blis:= )
	flexiblas? ( sci-libs/flexiblas:= )
	rocm? (
		>=dev-util/hip-${ROCM_VERSION}:=
		>=sci-libs/hipBLAS-${ROCM_VERSION}:=
		wmma? (
			>=sci-libs/rocWMMA-${ROCM_VERSION}:=
		)
	)
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	webp? ( media-libs/libwebp )
	webm? ( media-libs/libwebm )
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

src_prepare() {
	use cuda && cuda_src_prepare
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSD_BUILD_EXAMPLES=ON
		-DSD_WEBP=$(usex webp)
		-DSD_USE_SYSTEM_WEBP=$(usex webp)
		-DSD_WEBM=$(usex webm)
		-DSD_USE_SYSTEM_WEBM=$(usex webm)

		# GGML features controls
		-DSD_CUDA=$(usex cuda)
		-DSD_VULKAN=$(usex vulkan)
		-DSD_OPENCL=$(usex opencl)
		-DSD_RPC=ON

		-DSD_BUILD_SHARED_LIBS=OFF
		-DSD_SERVER_BUILD_FRONTEND=OFF # requires pnpm and network access

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
			-DSD_HIPBLAS=ON -DAMDGPU_TARGETS=$(get_amdgpu_flags) -DGPU_TARGETS=$(get_amdgpu_flags)
			-DGGML_HIP_ROCWMMA_FATTN=$(usex wmma)
		)
	fi

	cmake_src_configure
}
