# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="Audio tool using FFTW and libebur128"
HOMEPAGE="https://github.com/ray17x/bitfake2"
EGIT_REPO_URI="https://github.com/ray17x/bitfake2.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	media-libs/taglib
	sci-libs/fftw:3.0
	media-libs/libebur128
	media-libs/libsndfile
	media-video/ffmpeg[lame(+),opus(+),vorbis(+)]
	net-misc/curl
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
