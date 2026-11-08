# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

DESCRIPTION="A powerful tiling window manager for river implementing multiple layout options"
HOMEPAGE="https://codeberg.org/Sivecano/rhine"

ZIG_SLOT="0.17"
inherit zig

inherit git-r3
EGIT_REPO_URI="https://codeberg.org/Sivecano/rhine.git"

LICENSE="AGPL-3"
SLOT="0"
IUSE="+dbus"

DEPEND="
	dev-libs/wayland
"

BDEPEND="
	>=gui-wm/river-0.4.0
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
"

RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	zig_live_src_unpack
}

src_configure() {
	local my_zbs_args=(
		-Ddbus=$(usex dbus true false)
		-Dstrip=false # portage handles this
		-Dpie=true
	)

	zig_src_configure
}
