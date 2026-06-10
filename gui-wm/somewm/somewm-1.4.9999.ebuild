# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{4..5} luajit )

inherit meson lua-single

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/trip-zip/${PN}.git"

	if [[ ${PV} == 1.4.* ]]; then
		EGIT_BRANCH="release/1.4"
	fi
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/trip-zip/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="An AwesomeWM-compatible dynamic floating and tiling Wayland compositor"
HOMEPAGE="https://somewm.org https://github.com/trip-zip/somewm"

LICENSE="GPL-3"
SLOT="0"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	$(lua_gen_cond_dep 'dev-lua/lgi[${LUA_USEDEP}]')
	dev-libs/glib:2
	dev-libs/libffi
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/wayland-protocols
	gui-libs/wlroots:0.19
	sys-apps/dbus
	x11-base/xwayland
	x11-libs/cairo[X]
	x11-libs/gdk-pixbuf:2
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/xcb-util-wm
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	${LUA_DEPS}
	dev-build/meson
	dev-build/ninja
	dev-util/wayland-scanner
	virtual/pkgconfig
"

pkg_setup() {
	lua-single_pkg_setup
}

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	einfo "Migration check from AwesomeWM:"
	einfo "  somewm --check ~/.config/awesome/rc.lua"
	einfo ""
	einfo "Launching somewm from a TTY:"
	einfo "  somewm-session"
	einfo ""
	einfo "Further details at: https://somewm.org/docs/intro"
}
