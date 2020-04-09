# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-mod

COMMIT="9cf06524dfebda414675433141f771b36b7e68e8"

DESCRIPTION="Realtek 8192EU driver module for Linux kernel"
HOMEPAGE="https://github.com/Mange/rtl8192eu-linux-driver"
SRC_URI="https://github.com/Mange/rtl8192eu-linux-driver/archive/${COMMIT}.tar.gz -> rtl8192eu-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/rtl8192eu-linux-driver-${COMMIT}"

MODULE_NAMES="8192eu(net/wireless)"
BUILD_TARGETS="all"

CONFIG_CHECK="~!RTL8XXXU"
ERROR_RTL8XXXU="The RTL8XXXXU module is enabled in the kernel; it conflicts with this module."
