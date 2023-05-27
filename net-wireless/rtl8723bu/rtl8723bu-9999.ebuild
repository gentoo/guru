# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod

DESCRIPTION="Driver for the rtl8723 wireless chipset"
HOMEPAGE="https://github.com/lwfinger/rtl8723bu"
EGIT_REPO_URI="https://github.com/lwfinger/rtl8723bu.git"

LICENSE="GPL-2"

RDEPEND="sys-kernel/linux-firmware"

MODULE_NAMES="8723bu(net:)"

BUILD_TARGETS="all"

# Concurrent mode should be disable to avoid 2 conflicting wifi interfaces
src_prepare() {
	default
	sed -i '/EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE/s/^/#/' Makefile || die "sed failed !"
}

pkg_setup() {
	linux-mod_pkg_setup
}

src_install() {
	insinto /lib/firmware
	doins rtl8723b_fw.bin

	linux-mod_src_install
}
