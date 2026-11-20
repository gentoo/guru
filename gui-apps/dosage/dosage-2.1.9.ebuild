# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="Keep track of your treatments"
HOMEPAGE="https://github.com/diegopvlk/Dosage"
SRC_URI="https://github.com/diegopvlk/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^}"

LICENSE="CC-BY-SA-4.0 GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/gjs
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/libportal[introspection]
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	x11-libs/pango[introspection]
"
BDEPEND="
	dev-libs/glib:2
	dev-libs/libxml2:2
	dev-util/blueprint-compiler
	sys-devel/gettext
"

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
