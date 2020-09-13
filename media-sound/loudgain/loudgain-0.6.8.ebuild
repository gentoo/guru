# Copyright 1999-2020 Gentoo Authors
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

COMMON_DEPEND="
	media-video/ffmpeg
	media-libs/libebur128
	media-libs/taglib
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

src_install() {
	cmake_src_install
	dodoc README.md
}
