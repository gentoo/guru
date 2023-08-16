# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="Mastodon client, previously known as Tooth"
HOMEPAGE="https://github.com/GeopJr/Tuba"
MY_PN="Tuba"
SRC_URI="https://github.com/GeopJr/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND="
	>=app-crypt/libsecret-0.20
	>=dev-libs/glib-2.71.2
	>=dev-libs/json-glib-1.4.4
	>=dev-libs/libxml2-2.9.10
	>=dev-libs/libgee-0.8.5
	>=gui-libs/gtk-4.3:4
	>=gui-libs/libadwaita-1.2
	>=net-libs/libsoup-3
	gui-libs/gtksourceview:5
	>=app-text/gspell-1.12.1
"

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

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
