# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 vala meson gnome2-utils

DESCRIPTION="Tooth is a fork of the now archived Tootle, a gtk Mastodon client."
HOMEPAGE="https://github.com/GeopJr/Tooth"
EGIT_REPO_URI="https://github.com/GeopJr/Tooth.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND=">=dev-build/meson-0.50
>=dev-lang/vala-0.48
>=dev-libs/glib-2.0
>=dev-libs/json-glib-1.4.4
>=dev-libs/libxml2-2.9.10
>=dev-libs/libgee-0.8
gui-libs/gtk:4
>=gui-libs/libadwaita-1.2.0
>=app-crypt/libsecret-0.20"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"

VALA_MIN_API_VERSION=0.48

src_prepare() {
	default
	vala_setup
}

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
