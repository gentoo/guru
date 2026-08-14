# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs edo

DESCRIPTION="X11 daemon to auto run commands triggered by user specified events"
HOMEPAGE="https://codeberg.org/NRK/xuv"
SRC_URI="https://codeberg.org/NRK/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_compile() {
	edo $(tc-getCC) -o xuv xuv.c ${CFLAGS} ${LDFLAGS} -l X11
}

src_install() {
	dobin xuv
	doman etc/xuv.1
	doman etc/xuv.conf.5
}
