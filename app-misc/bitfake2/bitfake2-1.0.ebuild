# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3

DESCRIPTION="Audio tool using FFTW and libebur128"
HOMEPAGE="https://github.com/ray17x/bitfake2"
SRC_URI="https://github.com/ray17x/bitfake2/archive/refs/tags/v1.0.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"


RDEPEND="
	media-libs/taglib
	sci-libs/fftw:3.0
	media-libs/libebur128
	media-libs/libsndfile
	media-video/ffmpeg:0=[avcodec,avformat,avutil,swresample]
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}















