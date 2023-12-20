# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

MY_PN="8821cu-20210916"
COMMIT="eb52ece92607394ecc22e96b41671ec3e5b1fa30"
DESCRIPTION="Realtek 8821CU/RTL8811CU module for Linux kernel"
HOMEPAGE="https://github.com/morrownr/8821cu-20210916"
SRC_URI="https://github.com/morrownr/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

SLOT=0
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

src_compile() {
	linux-mod-r1_pkg_setup

	local modlist=( 8821cu=net/wireless )
	local modargs=( KSRC="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}
