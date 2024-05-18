# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg

DESCRIPTION="A Gemini browser for elementary OS"
HOMEPAGE="https://github.com/starfish-app/Starfish"
SRC_URI="https://github.com/${PN}-app/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee:=
	gui-libs/libhandy:1
	net-libs/gnutls:=
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"
BDEPEND="$(vala_depend)"

src_prepare() {
	default
	vala_src_prepare

	sed "s/'doc', 'starfish'/'doc', '${PF}'/" -i meson.build || die
	sed \
		-e "s:{{MESON_INSTALL_PREFIX}}:${EPREFIX}/usr:g" \
		-e "s:doc/starfish:doc/${PF}:g" \
		-i data/gschema.xml || die
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_gdk_pixbuf_update
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_schemas_update
	gnome2_gdk_pixbuf_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_schemas_update
	gnome2_gdk_pixbuf_update
	xdg_pkg_postrm
}
