# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg-utils

DESCRIPTION="System Information and Benchmark for Linux Systems"
HOMEPAGE="https://hardinfo2.org"
SRC_URI="https://github.com/hardinfo2/hardinfo2/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="GPL-2+ GPL-3+ LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X qt6 systemd wayland vulkan"
REQUIRED_USE="vulkan? ( || ( X wayland ) )"

DEPEND="
	>=dev-libs/glib-2.24
	dev-libs/json-glib
	net-libs/libsoup:3.0
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/pango
	virtual/zlib:=
	qt6? ( dev-qt/qtbase:6[opengl,widgets,gui] )
	vulkan? (
		dev-util/glslang
		media-libs/shaderc
		media-libs/vulkan-loader[X?,wayland?]
		X? ( x11-libs/libxcb )
		wayland? (
			dev-libs/wayland
			gui-libs/libdecor
		)
	)
"
RDEPEND="
	${DEPEND}
	app-benchmarks/sysbench
	net-misc/iperf:3
	sys-apps/dmidecode
	sys-apps/fwupd
	sys-apps/gawk
	sys-apps/lm-sensors
	sys-fs/lsscsi
	sys-fs/udisks:2
	x11-apps/mesa-progs[X]
	x11-apps/xrandr
	x11-misc/xdg-utils
	vulkan? ( dev-util/vulkan-tools[X?,wayland?] )
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -i -e 's:-O0 ::' CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	filter-flags -O*

	local mycmakeargs=(
		-DHARDINFO2_QT6=$(usex qt6)
		-DHARDINFO2_QT5=0
		-DHARDINFO2_SERVICE=$(usex systemd)
		-DHARDINFO2_VK=$(usex vulkan 1 0)
		-DHARDINFO2_VK_WAYLAND=$(usex wayland)
		-DHARDINFO2_VK_X11=$(usex X)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
