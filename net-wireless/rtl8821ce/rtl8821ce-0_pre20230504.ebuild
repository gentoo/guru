# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1
SLOT=0

COMMIT="a478095a45d8aa957b45be4f9173c414efcacc6f"

DESCRIPTION="Realtek RTL8821CE Driver module for Linux kernel"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce"
SRC_URI="https://github.com/tomaspinho/rtl8821ce/archive/${COMMIT}.tar.gz -> rtl8821ce-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/rtl8821ce-${COMMIT}"

CONFIG_CHECK="~!RTW88_8821CE"
ERROR_RTL8XXXU="The RTW88_8821CE module is enabled in the kernel; it conflicts with this module."

src_compile() {
	linux-mod-r1_pkg_setup

	local modlist=(8821ce=net/wireless)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
