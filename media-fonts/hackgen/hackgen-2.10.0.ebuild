# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="v${PV}"
MY_P="HackGen_${MY_PV}"
MY_P_NF="HackGen_NF_${MY_PV}"

DESCRIPTION="HackGen is a composite font of Hack and GenJyuu-Gothic."
HOMEPAGE="https://github.com/yuru7/HackGen"
SRC_URI="
	https://github.com/yuru7/HackGen/releases/download/${MY_PV}/${MY_P}.zip
	https://github.com/yuru7/HackGen/releases/download/${MY_PV}/${MY_P_NF}.zip
"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

BDEPEND="app-arch/unzip"

src_install() {
	mv ${MY_P}/* ${MY_P_NF}/* . || die
	font_src_install
}
