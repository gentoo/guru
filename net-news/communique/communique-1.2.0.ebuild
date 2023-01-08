# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="RSS Reader with cross-platform sync"
HOMEPAGE="https://github.com/Suzie97/Communique"
SRC_URI="https://github.com/Suzie97/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
PROPERTIES="test_network"

DEPEND="
	app-crypt/libsecret[vala]
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/granite:=
	dev-libs/gumbo
	dev-libs/json-glib[introspection]
	dev-libs/libgee:0.8=[introspection]
	dev-libs/libpeas
	dev-libs/libxml2:2
	gui-libs/libhandy:1[vala]
	media-libs/gst-plugins-base[introspection]
	media-libs/gstreamer:1.0[introspection]
	net-libs/gnome-online-accounts:=[vala]
	net-libs/libsoup:2.4[vala]
	net-libs/rest:0.7[introspection]
	net-libs/webkit-gtk:4[introspection]
	net-misc/curl
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	dev-libs/glib:2
	sys-devel/gettext
"

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
