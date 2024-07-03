# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Minesweeper clone for the X11 windowing system"
HOMEPAGE="https://salsa.debian.org/debian/xdemineur"

SRC_URI="https://deb.debian.org/debian/pool/main/x/${PN}/xdemineur_${PV}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	x11-misc/imake
"
RDEPEND="
	x11-libs/libX11
	x11-libs/libXpm
"
DEPEND="
	${RDEPEND}
"

PATCHES=(
	"${FILESDIR}/${P}-include.patch"
)

src_configure() {
	xmkmf || die
}

src_compile() {
	emake
}
