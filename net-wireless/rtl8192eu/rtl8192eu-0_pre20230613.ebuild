# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1
SLOT=0
COMMIT="f2fc8af7ab58d2123eed1aa4428e713cdfc27976"

DESCRIPTION="Realtek 8192EU driver module for Linux kernel"
HOMEPAGE="https://github.com/Mange/rtl8192eu-linux-driver"
SRC_URI="https://github.com/Mange/rtl8192eu-linux-driver/archive/${COMMIT}.tar.gz -> rtl8192eu-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/rtl8192eu-linux-driver-${COMMIT}"

CONFIG_CHECK="~!RTL8XXXU"
ERROR_RTL8XXXU="The RTL8XXXXU module is enabled in the kernel; it conflicts with this module."

src_compile() {
	linux-mod-r1_pkg_setup
	local modlist=(8192eu=net/wireless)
	local modargs=(KSRC=$KV_OUT_DIR)

	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
}
