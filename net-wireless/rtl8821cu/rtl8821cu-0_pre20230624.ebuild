# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

SLOT=0

COMMIT="dc9ee6c6a8b47d0e365fcf1977439c7243da71d5"

DESCRIPTION="Realtek 8821CU/RTL8811CU module for Linux kernel"
HOMEPAGE="https://github.com/morrownr/8821cu-20210916"
SRC_URI="https://github.com/morrownr/8821cu-20210916/archive/${COMMIT}.tar.gz -> rtl8821cu-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/8821cu-20210916-${COMMIT}"

src_compile() {
	linux-mod-r1_pkg_setup

	local modlist=(8821cu=net/wireless)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
