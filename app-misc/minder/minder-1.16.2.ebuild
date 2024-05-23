# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="Mind-mapping application for Elementary OS."
HOMEPAGE="https://github.com/phase1geo/Minder"
SRC_URI="https://github.com/phase1geo/Minder/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Minder-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/discount
	dev-lang/vala
	dev-libs/granite
	dev-libs/json-glib
	gui-libs/libhandy[vala]
	x11-libs/gtksourceview:4[vala]
"

DEPEND="
	${RDEPEND}
	app-text/discount
"

src_prepare() {
	default
	vala_setup

	# Workaround for #871687
	sed -i "s/meson.add_install_script('meson\/post_install.py')//g" meson.build || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	gnome2_schemas_update
}
