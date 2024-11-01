# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="System Information and Benchmark for Linux Systems"
HOMEPAGE="https://www.hardinfo2.org"
SRC_URI="https://github.com/hardinfo2/hardinfo2/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="GPL-2+ GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="benchmark fwupd +gtk3"

DEPEND="
	gtk3? ( x11-libs/gtk+:3 ) !gtk3? ( x11-libs/gtk+:2 )
	>=dev-libs/glib-2.24
	sys-libs/zlib
	dev-libs/json-glib
	net-libs/libsoup:3.0
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/libX11
	x11-libs/pango
"
RDEPEND="
	${DEPEND}
	dev-util/vulkan-tools
	net-misc/iperf:3
	sys-apps/dmidecode
	sys-apps/lm-sensors
	sys-fs/lsscsi
	sys-fs/udisks:2
	x11-apps/mesa-progs
	x11-apps/xrandr
	x11-misc/xdg-utils
	benchmark? ( app-benchmarks/sysbench )
	fwupd? ( sys-apps/fwupd )
"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DHARDINFO2_GTK3=$(usex gtk3)
		-DHARDINFO2_QT5=0
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
