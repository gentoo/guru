# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson systemd udev

DESCRIPTION="Visual Voicemail Player"
HOMEPAGE="https://gitlab.com/kop316/vvmplayer"
SRC_URI="https://gitlab.com/kop316/vvmplayer/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-libs/glib-2.50
	>=x11-libs/gtk+-3.22.0
	>=gui-libs/libhandy-1.0
	>=media-libs/gstreamer-1.16.0
	gnome-extra/evolution-data-server
	media-sound/callaudiod
	net-voip/vvmd
"

DEPEND=""

src_install() {
	meson_src_install
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
