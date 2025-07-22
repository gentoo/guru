# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MyPN="whisper.cpp"
MyP="${MyPN}-${PV}"

DESCRIPTION="Port of OpenAI's Whisper model in C/C++ "
HOMEPAGE="https://github.com/ggml-org/whisper.cpp"
SRC_URI="https://github.com/ggml-org/whisper.cpp/archive/refs/tags/v${PV}.tar.gz -> ${MyP}.tar.gz"

S="${WORKDIR}/${MyP}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="blas cuda hip opencl sdl2 vulkan"

CDEPEND="blas? ( sci-libs/openblas )
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	hip? ( sci-libs/hipBLAS:= )
	opencl? ( sci-libs/clblast:= )
	sdl2? ( media-libs/libsdl2:= )"
DEPEND="${CDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
RDEPEND="${CDEPEND}
	vulkan? ( media-libs/vulkan-loader )
"

src_configure() {
	# Note: CUDA and HIP are currently untested. Build failures may occur.
	# Turning off examples causes errors during configure
	# -DWHISPER_BUILD_TESTS=$(usex test)
	local mycmakeargs=(
		-DWHISPER_BUILD_EXAMPLES=ON
		-DGGML_BLAS=$(usex blas)
		-DGGML_CLBLAST=$(usex opencl)
		-DGGML_CUBLAS=$(usex cuda)
		-DGGML_HIPBLAS=$(usex hip)
		-DGGML_VULKAN=$(usex vulkan)
		-DWHISPER_SDL2=$(usex sdl2)
	)
	cmake_src_configure
}
