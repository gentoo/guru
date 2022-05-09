# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="PTP IEEE 1588 stack for Linux"
HOMEPAGE="https://sourceforge.net/projects/linuxptp"
SRC_URI="mirror://sourceforge/project/${PN}/v$(ver_cut 1-2)/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="sys-kernel/linux-headers"

RESTRICT="test" #no tests
PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	tc-export CC
	default
}

src_install() {
	default
	dodoc README.org
}
