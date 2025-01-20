# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="v${PV}"

DESCRIPTION="moralerspace is a composite font of Monaspace and IBM Plex Sans JP."
HOMEPAGE="https://github.com/yuru7/moralerspace"
SRC_URI="
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}_${MY_PV}.zip
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}HW_${MY_PV}.zip
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}JPDOC_${MY_PV}.zip
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}HWJPDOC_${MY_PV}.zip
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}NF_${MY_PV}.zip
	https://github.com/yuru7/moralerspace/releases/download/${MY_PV}/${PN^}HWNF_${MY_PV}.zip
"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

BDEPEND="app-arch/unzip"

src_install() {
	mv ${PN^}*/*.${FONT_SUFFIX} . || die
	font_src_install
}
