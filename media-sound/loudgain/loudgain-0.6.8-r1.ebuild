# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Versatile ReplayGain 2.0 loudness normalizer"
HOMEPAGE="https://github.com/Moonbase59/loudgain"
SRC_URI="https://github.com/Moonbase59/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#REQUIRED_USE=""

# Bug 922026: `av_register_all` is deprecated and maybe not present in ffmpeg-6
# (changelog: <https://github.com/FFmpeg/FFmpeg/blob/70d25268c21cbee5f08304da95be1f647c630c15/doc/APIchanges#L86>).
# <https://ffmpeg.org/pipermail/ffmpeg-devel/2018-February/225051.html> says these
# functions "don't do anything" so simply removing these call would work. However,
# loudgain is not updated for some years and I (ebuild maintainer) am not sure
# if it would work with ffmpeg-6, so restricting to <ffmpeg-5 here.
COMMON_DEPEND="
	<media-video/ffmpeg-5
	media-libs/libebur128
	media-libs/taglib
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

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
