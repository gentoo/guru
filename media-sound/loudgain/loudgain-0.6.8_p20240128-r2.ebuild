# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_COMMIT="079f82c613ea1e3597ad5e2cad077829fd75d2c9"
MY_P="${PN}-${MY_COMMIT}"

DESCRIPTION="Versatile ReplayGain 2.0 loudness normalizer"
HOMEPAGE="https://github.com/Moonbase59/loudgain"
SRC_URI="https://github.com/Moonbase59/${PN}/archive/${MY_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#REQUIRED_USE=""

COMMON_DEPEND="
	media-video/ffmpeg:=
	media-libs/libebur128
	media-libs/taglib
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

PATCHES=(
	"${FILESDIR}/loudgain-0.6.8-github-pr34-manpage.patch"
	"${FILESDIR}/loudgain-0.6.8-github-pr50-ffmpeg6.patch"
	"${FILESDIR}/loudgain-0.6.8-github-pr53-print-taglib-version.patch"
	"${FILESDIR}/loudgain-0.6.8-github-pr65-ffmpeg6-gcc14.patch"
	"${FILESDIR}/loudgain-0.6.8-github-pr66-ffmpeg7.patch"
	"${FILESDIR}/loudgain-0.6.8-respect-build-flags.patch"
)

src_install() {
	cmake_src_install
	dodoc README.md
}
