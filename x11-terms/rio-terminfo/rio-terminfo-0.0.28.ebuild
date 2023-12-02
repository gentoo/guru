# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="rio"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Terminfo for Rio, a hardware-accelerated GPU terminal emulator powered by WebGPU"
HOMEPAGE="https://raphamorim.io/rio/"
SRC_URI="
	https://github.com/raphamorim/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz
"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="sys-libs/ncurses"

src_compile() { :; }

src_install() {
	dodir "/usr/share/terminfo"
	tic -xo "${ED}/usr/share/terminfo" "misc/rio.terminfo" || die
}
