# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Audio tool using FFTW and libebur128"
HOMEPAGE="https://github.com/ray17x/bitfake2"
SRC_URI="https://github.com/ray17x/bitfake2/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/taglib
	sci-libs/fftw:3.0
	media-libs/libebur128
	media-libs/libsndfile
	media-video/ffmpeg[lame(+),vorbis(+),opus(+)]
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
