# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="v${PV}"
MY_P="PlemolJP_${MY_PV}"
MY_P_NF="PlemolJP_NF_${MY_PV}"
MY_P_HS="PlemolJP_HS_${MY_PV}"

DESCRIPTION="PlemolJP is a composite font of IBM Plex Mono and IBM Plex Sans JP."
HOMEPAGE="https://github.com/yuru7/PlemolJP"
SRC_URI="
	https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P}.zip
	https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P_NF}.zip
	https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P_HS}.zip
"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

BDEPEND="app-arch/unzip"

src_install() {
	mv ${MY_P}/*/* ${MY_P_NF}/*/* ${MY_P_HS}/*/* . || die
	font_src_install
}
