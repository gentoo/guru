# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg gnome2-utils

DESCRIPTION="GTK implementation for WPE platform"
HOMEPAGE="https://github.com/Igalia/wig"

LICENSE="MIT"
SLOT="0"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Igalia/wig.git"
else
	KEYWORDS="~amd64"
fi

IUSE="wayland X"
REQUIRED_USE="
	|| ( wayland X )
"

DEPEND="
	dev-libs/glib:2
	gui-libs/wpe-platform-gtk:1.0[wayland?,X?]
	>=net-libs/wpewebkit-2.51.3:2.0[wayland?]
	>=gui-libs/libadwaita-1.9:1
	net-libs/libpsl
	dev-db/sqlite:3
	net-libs/libsoup:3.0
	dev-libs/json-glib
	gui-libs/gtk:4[wayland?,X?]
	x11-libs/cairo[X?]
	gnome-base/gsettings-desktop-schemas
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

pkg_postins() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
