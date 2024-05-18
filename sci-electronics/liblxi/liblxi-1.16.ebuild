# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

DESCRIPTION="Implementation of the LAN eXtensions for Instrumentation (LXI)"
HOMEPAGE="https://github.com/lxi-tools/liblxi"
SRC_URI="https://github.com/lxi-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=net-libs/libtirpc-1.3.2
	>=dev-libs/libxml2-2.9.14-r1
	>=net-dns/avahi-0.8-r5
"

DEPEND="${RDEPEND}"

BDEPEND="virtual/pkgconfig"
