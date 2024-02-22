# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs edo

DESCRIPTION="Minimal X11 rectangle selection tool"
HOMEPAGE="https://codeberg.org/NRK/selx"

SRC_URI="https://codeberg.org/NRK/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

KEYWORDS="~amd64"
LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
"
DEPEND="${RDEPEND}"

src_compile() {
	edo $(tc-getCC) -o selx selx.c ${CFLAGS} ${LDFLAGS} -l X11 -l Xext -l Xrandr
}

src_install() {
	dobin selx
	doman selx.1
}
