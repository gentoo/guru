# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

HASH_COMMIT="819b01bdeae127fc3afb648aaaf53249863fa024"

inherit linux-mod linux-info

DESCRIPTION="Linux Kernel Runtime Guard"
HOMEPAGE="https://www.openwall.com/lkrg"
SRC_URI="https://github.com/openwall/lkrg/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

MODULE_NAMES="p_lkrg(misc:${S}:${S})"

pkg_setup() {
	local CONFIG_CHECK="MODULE_UNLOAD KALLSYMS_ALL JUMP_LABEL"
	linux-mod_pkg_setup

	# compile against selected (not running) target
	BUILD_PARAMS="P_KVER=${KV_FULL} P_KERNEL=${KERNEL_DIR}"
	BUILD_TARGETS="all"
}

pkg_postinst() {
	einfo "Usage:"
	einfo "modprobe p_lkrg p_init_log_level=3"
}
