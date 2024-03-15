# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV=$(ver_rs 1- "")
MY_P="fonts-DSEG_v${MY_PV}"

DESCRIPTION="An open-source Chinese font derived from IPAmj Mincho"
HOMEPAGE="https://github.com/lxgw/LxgwNeoZhiSong"
SRC_URI="
	https://github.com/keshikan/DSEG/releases/download/v${PV}/${MY_P}.zip -> ${P}.zip
"
S="${WORKDIR}/${MY_P}"
LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~loong ~riscv ~x86"

BDEPEND="app-arch/unzip"

FONT_S="${S}"
FONT_SUFFIX="ttf"

src_unpack() {
	default
	mv "${S}"/*/*."${FONT_SUFFIX}" "${S}" || die
}
