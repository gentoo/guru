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
IUSE="blas cuda hip opencl sdl2"

DEPEND="blas? ( virtual/blas )
	cuda? ( dev-util/nvidia-cuda-toolkit:= )
	hip? ( sci-libs/hipBLAS:= )
	opencl? ( sci-libs/clblast:= )
	sdl2? ( media-libs/libsdl2:= )"
RDEPEND="${DEPEND}"

# Enabling multiple may lead to build failures, whisper-cpp won't use more than one either way
REQUIRED_USE="?? ( blas cuda hip opencl )"

src_configure() {
	# Note: CUDA and HIP are currently untested. Build failures may occur.
	# Turning off examples causes errors during configure
	# -DWHISPER_BUILD_TESTS=$(usex test)
	local mycmakeargs=(
		-DWHISPER_BUILD_EXAMPLES=ON
		-DWHISPER_BLAS=$(usex blas)
		-DWHISPER_CLBLAST=$(usex opencl)
		-DWHISPER_CUBLAS=$(usex cuda)
		-DWHISPER_HIPBLAS=$(usex hip)
		-DWHISPER_SDL2=$(usex sdl2)
	)
	cmake_src_configure
}
