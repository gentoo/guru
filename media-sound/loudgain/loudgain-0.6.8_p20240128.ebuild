# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="079f82c613ea1e3597ad5e2cad077829fd75d2c9"
MY_P="${PN}-${MY_COMMIT}"

DESCRIPTION="Versatile ReplayGain 2.0 loudness normalizer"
HOMEPAGE="https://github.com/Moonbase59/loudgain"
SRC_URI="https://github.com/Moonbase59/${PN}/archive/079f82c613ea1e3597ad5e2cad077829fd75d2c9.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#REQUIRED_USE=""

# FFmpeg 7 introduced API breaking change that affects loudgain.
# See <https://github.com/Moonbase59/loudgain/issues/67>.
COMMON_DEPEND="
	<media-video/ffmpeg-7:=
	media-libs/libebur128
	media-libs/taglib
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/loudgain-0.6.8-github-pr50-ffmpeg6.patch"
	"${FILESDIR}/loudgain-0.6.8-github-pr65-ffmpeg6-gcc14.patch"
)

src_prepare() {
	sed -e 's/^SET(CMAKE_C_FLAGS "/SET(CMAKE_C_FLAGS "${CMAKE_C_CFLAGS} /' \
		-e 's/^SET(CMAKE_CXX_FLAGS "/SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /' \
		-e 's/^\(\s*COMPILE_FLAGS.*\) -g\([\s"]\)$/\1\2/' \
		-i CMakeLists.txt || die "cannot patch CMakeLists.txt"
	cat CMakeLists.txt

	cmake_src_prepare
}

src_install() {
	cmake_src_install
	dodoc README.md
}
