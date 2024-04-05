# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson gnome2-utils vala xdg

DESCRIPTION="Run your SQL query"
HOMEPAGE="https://github.com/ppvan/psequel"
SRC_URI="https://github.com/ppvan/psequel/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-db/postgresql
	dev-db/pg_query_vala
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/vala-0.56
	>=gui-libs/gtk-4.10.0:4
	>=gui-libs/gtksourceview-5.0:5
	>=dev-libs/glib-2.74.0:2
	>=dev-libs/json-glib-1.6.0
	>=gui-libs/libadwaita-1.0:1
	>=dev-db/postgresql-15.3
	dev-db/pg_query_vala
"

src_prepare() {
	default
	vala_setup
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
	xdg_icon_cache_update
}
