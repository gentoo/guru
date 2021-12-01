# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod toolchain-funcs
BUILD_PARAMS="CC=$(tc-getCC) V=1 KSRC=${KERNEL_DIR}"

COMMIT="ca204c60724d23ab10244f920d4e50759ed1affb"

DESCRIPTION="Realtek RTL8821CE Driver module for Linux kernel"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce"
SRC_URI="https://github.com/tomaspinho/rtl8821ce/archive/${COMMIT}.tar.gz -> rtl8821ce-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/rtl8821ce-${COMMIT}"

MODULE_NAMES="8821ce(net/wireless)"
BUILD_TARGETS="all"
CONFIG_CHECK="~!RTW88_8821CE"
ERROR_RTL8XXXU="The RTW88_8821CE module is enabled in the kernel; it conflicts with this module."
