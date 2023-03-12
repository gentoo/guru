# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 gnome2-utils meson vala xdg-utils

DESCRIPTION="Mastodon client written in GTK3"
HOMEPAGE="https://gitlab.gnome.org/World/tootle"
EGIT_REPO_URI="https://gitlab.gnome.org/World/tootle"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-crypt/libsecret
	dev-libs/glib:2
	>=dev-libs/granite-0.5.2:=
	dev-libs/json-glib
	dev-libs/libgee:0.8=
	dev-libs/libxml2:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	net-libs/libsoup:2.4
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	sys-devel/gettext
"

src_prepare() {
	vala_setup
	default
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postinst
	gnome2_schemas_update
}
