# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ROCM_VERSION="6.3"

inherit cmake cuda rocm linux-info

DESCRIPTION="llama.cpp fork with additional SOTA quants and improved performance"
HOMEPAGE="https://github.com/ikawrakow/ik_llama.cpp"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ikawrakow/ik_llama.cpp.git"
else
	MY_PV="b${PV#0_pre}"
	SRC_URI="https://github.com/ikawrakow/ik_llama.cpp/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/ik_llama.cpp-${MY_PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
CPU_FLAGS_X86=( avx avx2 f16c )

# wwma USE explained here: https://github.com/ikawrakow/ik_llama.cpp/blob/master/docs/build.md#hipblas
IUSE="curl openblas +openmp blis rocm cuda vulkan flexiblas wmma"

REQUIRED_USE="
	?? (
		openblas
		blis
		flexiblas
	)
	wmma? (
		rocm
	)
"

# curl is needed for pulling models from huggingface
CDEPEND="
	curl? ( net-misc/curl:= )
	openblas? ( sci-libs/openblas:= )
	openmp? ( llvm-runtimes/openmp:= )
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
"
DEPEND="${CDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
RDEPEND="${CDEPEND}
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
		-DCMAKE_INSTALL_INCLUDEDIR=include/ik_llama.cpp
		-DLLAMA_BUILD_TESTS=OFF
		-DLLAMA_BUILD_EXAMPLES=ON
		-DLLAMA_BUILD_SERVER=ON
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DGGML_NATIVE=0	# don't set march
		-DGGML_RPC=ON
		-DLLAMA_CURL=$(usex curl)
		-DBUILD_NUMBER="1"
		-DGENTOO_REMOVE_CMAKE_BLAS_HACK=ON
		-DGGML_CUDA=$(usex cuda)
		-DGGML_OPENMP=$(usex openmp)
		-DGGML_VULKAN=$(usex vulkan)

		# avoid clashing with whisper.cpp
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)/ik_llama.cpp"
		-DCMAKE_INSTALL_RPATH="${EPREFIX}/usr/$(get_libdir)/ik_llama.cpp"
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
			-DGGML_HIP=ON -DAMDGPU_TARGETS=$(get_amdgpu_flags)
			-DGGML_HIP_ROCWMMA_FATTN=$(usex wmma)
		)
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# avoid clashing with whisper.cpp
	rm -rf "${ED}/usr/include"
	mkdir -p "${ED}/usr/sbin"
	for f in "${ED}"/usr/bin/llama-*; do
		mv "$f" "${ED}/usr/sbin/ik_$(basename $f)" || die
	done
	rm -rf "${ED}/usr/bin"
}
