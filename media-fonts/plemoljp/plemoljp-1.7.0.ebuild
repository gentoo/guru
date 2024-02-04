# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="PlemolJP"
MY_PV="v${PV}"
MY_P="${MY_PN}_${MY_PV}"
MY_P_HS="${MY_PN}_HS_${MY_PV}"
MY_P_NF="${MY_PN}_NF_${MY_PV}"

DESCRIPTION="PlemolJP is a composite font of IBM Plex Mono and IBM Plex Sans JP."
HOMEPAGE="https://github.com/yuru7/PlemolJP"
SRC_URI="https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P}.zip
	hiddenspace? ( https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P_HS}.zip )
	nerdfonts? ( https://github.com/yuru7/PlemolJP/releases/download/${MY_PV}/${MY_P_NF}.zip )
"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="hiddenspace nerdfonts"

BDEPEND="app-arch/unzip"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

src_unpack() {
	default
	mv ${MY_P}/*/*.${FONT_SUFFIX} . || die
	if use hiddenspace; then
		mv ${MY_P_HS}/*/*.${FONT_SUFFIX} . || die
	fi
	if use nerdfonts; then
		mv ${MY_P_NF}/*/*.${FONT_SUFFIX} . || die
	fi
}
