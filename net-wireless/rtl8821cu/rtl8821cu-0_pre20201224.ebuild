# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-mod

COMMIT="deff094b9d361b75dd3522aab4eb7f2ca3f3b0be"

DESCRIPTION="Realtek 8821CU/RTL8811CU module for Linux kernel"
HOMEPAGE="https://github.com/brektrou/rtl8821CU"
SRC_URI="https://github.com/brektrou/rtl8821CU/archive/${COMMIT}.tar.gz -> rtl8821cu-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/rtl8821CU-${COMMIT}"

MODULE_NAMES="8821cu(net/wireless)"
BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} ARCH=$(uname -m | sed -e s/i.86/i386/) KSRC=${KV_DIR} KERN_VER=${KV_FULL}"
}
