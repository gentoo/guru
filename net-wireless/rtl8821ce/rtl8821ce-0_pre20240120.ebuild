# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_PN="rtl8821ce"
COMMIT="66983b69120a13699acf40a12979317f29012111"
DESCRIPTION="Realtek RTL8821CE Driver module for Linux kernel"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce"
SRC_URI="https://github.com/tomaspinho/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

SLOT=0
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

CONFIG_CHECK="~!RTW88_8821CE"
ERROR_RTL8XXXU="The RTW88_8821CE module is enabled in the kernel; it conflicts with this module."

src_compile() {
	local modlist=( 8821ce=net/wireless )
	local modargs=( KSRC="${KV_OUT_DIR}" )

	linux-mod-r1_src_compile
}
