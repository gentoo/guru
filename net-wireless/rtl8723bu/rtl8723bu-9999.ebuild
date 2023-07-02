# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="Driver for the rtl8723 wireless chipset"
HOMEPAGE="https://github.com/lwfinger/rtl8723bu"
EGIT_REPO_URI="https://github.com/lwfinger/rtl8723bu.git"
EGIT_BRANCH=master

LICENSE="GPL-2"
SLOT="0"

RDEPEND="sys-kernel/linux-firmware"

# Concurrent mode should be disable to avoid 2 conflicting wifi interfaces
src_prepare() {
	default
	sed -i '/EXTRA_CFLAGS += -DCONFIG_CONCURRENT_MODE/s/^/#/' Makefile || die "sed failed !"
}

src_compile() {
	local modlist=( 8723bu=net/wireless )
	local modargs=( KSRC="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}

src_install() {
	insinto /lib/firmware
	doins rtl8723b_fw.bin

	linux-mod-r1_src_install
}
