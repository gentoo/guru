# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A CLI program to play back or render SPC files."
HOMEPAGE="https://codeberg.org/jneen/spct"
SRC_URI="https://codeberg.org/jneen/spct/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	media-libs/game-music-emu
	sys-libs/ncurses:=
"
BDEPEND="virtual/pkgconfig"
RDEPEND="
	${DEPEND}
"

src_compile() {
	emake VERSION="${PV}" LIBGME_NO_VENDOR=1
}

src_install() {
	emake VERSION="${PV}" LIBGME_NO_VENDOR=1 PREFIX="${D}/usr" install
	dodoc README.md
}
