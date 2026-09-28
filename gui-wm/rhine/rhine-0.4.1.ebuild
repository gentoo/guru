# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A powerful tiling window manager for river implementing multiple layout options"
HOMEPAGE="https://codeberg.org/Sivecano/rhine"

declare -g -r -A ZBS_DEPENDENCIES=(
	[mr_tween-0.1.0-WbH78YcBAQD3RF4QfCYFF6EJCYzAzdIU4BHCj0pFI5yq.tar.gz]='https://codeberg.org/Games-by-Mason/mr_tween/archive/v0.1.0.tar.gz'
	[tributary-0.4.1-tqCfWzbUAACWcbClrEM-xQIfPNogwri6nGNyWrt123vK.tar.gz]='https://codeberg.org/Sivecano/libtributary/archive/0.5.0.tar.gz'
	[wayland-0.6.0-lQa1kqz8AQADQmdNJsNhLoNHcnEGEUjrOaPV-dtEnEmX.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.6.0.tar.gz'
)

ZIG_SLOT="0.16"
inherit zig

SRC_URI="
	https://codeberg.org/Sivecano/rhine/archive/${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

S="${WORKDIR}/${PN}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dbus"

DEPEND="
	dev-libs/wayland
	dbus? ( sys-apps/dbus )
"

BDEPEND="
	>=gui-wm/river-0.4.0
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
"

RDEPEND="${DEPEND}"

src_configure() {
	local my_zbs_args=(
		-Dnotify=$(usex dbus true false)
		-Dstrip=false # portage handles this
		-Dpie=true
	)

	zig_src_configure
}
