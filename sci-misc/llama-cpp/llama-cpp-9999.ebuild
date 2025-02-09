# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ "${PV}" != "9999" ]]; then
	KEYWORDS="~amd64"
	MY_PV="b${PV#0_pre}"
	S="${WORKDIR}/llama.cpp-${MY_PV}"
	SRC_URI="https://github.com/ggerganov/llama.cpp/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ggerganov/llama.cpp.git"
fi

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggerganov/llama.cpp"

LICENSE="MIT"
SLOT="0"
CPU_FLAGS_X86=( avx avx2 f16c )
IUSE="curl openblas blis"
REQUIRED_USE="?? ( openblas blis )"

# curl is needed for pulling models from huggingface
# numpy is used by convert_hf_to_gguf.py
DEPEND="
	curl? ( net-misc/curl:= )
	openblas? ( sci-libs/openblas:= )
	blis? ( sci-libs/blis:= )
"
RDEPEND="${DEPEND}
	dev-python/numpy
"
PATCHES=( "${FILESDIR}/blas-ld.diff" )

src_configure() {
	local mycmakeargs=(
		-DLLAMA_BUILD_TESTS=OFF
		-DLLAMA_BUILD_SERVER=ON
		-DCMAKE_SKIP_BUILD_RPATH=ON
		-DGGML_NATIVE=0	# don't set march
		-DLLAMA_CURL=$(usex curl ON OFF)
		-DBUILD_NUMBER="1"
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

	cmake_src_configure
}
