# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PV="v${PV}"
MY_P="UDEVGothic_${MY_PV}"
MY_P_NF="UDEVGothic_NF_${MY_PV}"
MY_P_HS="UDEVGothic_HS_${MY_PV}"

DESCRIPTION="UDEV Gothic is a composite font of BIZ UD Gothic and JetBrains Mono."
HOMEPAGE="https://github.com/yuru7/udev-gothic"
SRC_URI="
	https://github.com/yuru7/udev-gothic/releases/download/${MY_PV}/${MY_P}.zip
	https://github.com/yuru7/udev-gothic/releases/download/${MY_PV}/${MY_P_NF}.zip
	https://github.com/yuru7/udev-gothic/releases/download/${MY_PV}/${MY_P_HS}.zip
"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

BDEPEND="app-arch/unzip"

src_install() {
	mv ${MY_P}/* ${MY_P_NF}/* ${MY_P_HS}/* . || die
	font_src_install
}
