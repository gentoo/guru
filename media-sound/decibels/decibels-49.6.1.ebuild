# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome.org gnome2-utils meson xdg

DESCRIPTION="Play audio files"
HOMEPAGE="https://gitlab.gnome.org/GNOME/decibels"

LICENSE="GPL-2+ LGPL-2+ MIT CC-BY-3.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.82.0-r2:=
	>=gui-libs/gtk-4.5:4
	>=dev-libs/gjs-1.71.0
	>=app-misc/geoclue-2.3.1:2.0
	>=gui-libs/libadwaita-1.4_alpha:1=
	media-libs/gstreamer
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
"
RDEPEND="${DEPEND}
	gnome-base/gsettings-desktop-schemas
"
BDEPEND="
	dev-libs/appstream-glib
	dev-util/blueprint-compiler
	dev-lang/typescript
	dev-build/meson
	virtual/pkgconfig
"
PATCHES=(
	"${FILESDIR}"/001-typescript.patch
)

src_configure() {
	meson_src_configure -Dprofile=default
}

src_install () {
	meson_install
	dosym -r /usr/bin/org.gnome.Decibels /usr/bin/decibels
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
