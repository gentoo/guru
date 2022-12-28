# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Mastodon client written in GTK3"
HOMEPAGE="https://github.com/bleakgrey/tootle"
EGIT_REPO_URI="https://gitlab.gnome.org/World/tootle"
LICENSE="GPL-3"

SLOT="0"

RDEPEND="
	dev-libs/json-glib
	>=dev-libs/granite-0.5.2
	gui-libs/libhandy:1.0/0
	net-libs/libsoup
"
DEPEND="
	${RDEPEND}
	dev-util/meson
	dev-lang/vala
	virtual/pkgconfig
"

src_prepare() {
	vala_src_prepare
	default
}

src_install() {
	meson_src_install
	dosym "${EPREFIX}"/usr/bin/{com.github.bleakgrey.,}tootle
}

pkg_preinst() {
	gnome2_gconf_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_gconf_install
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
