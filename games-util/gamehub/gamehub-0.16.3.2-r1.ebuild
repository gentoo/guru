# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

MY_PN="GameHub"
MY_PV="$(ver_rs 3 '-')-master"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="GameHub is a unified library for all your games"
HOMEPAGE="https://tkashkin.github.io/projects/gamehub/ https://github.com/tkashkin/gamehub"
SRC_URI="https://github.com/tkashkin/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8=
	>=dev-libs/libmanette-0.2
	dev-libs/libxml2
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4=
	sys-auth/polkit
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXtst
"
DEPEND="${RDEPEND}"
BDEPEND="$(vala_depend)"

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
