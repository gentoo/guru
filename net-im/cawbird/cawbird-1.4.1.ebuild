# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"
inherit vala meson xdg

DESCRIPTION="Cawbird is a fork of the Corebird Twitter client from Baedert."
HOMEPAGE="https://github.com/IBBoard/cawbird"
SRC_URI="https://github.com/IBBoard/cawbird/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	gui-libs/gtk
	>=x11-libs/gtk+-3.22
	>=dev-libs/glib-2.44
	>=dev-libs/json-glib-1.0
	>=dev-db/sqlite-3.0
	>=net-libs/libsoup-2.4
	net-libs/liboauth
	>=sys-devel/gettext-0.19
	media-libs/gst-plugins-base
	media-libs/gst-plugins-bad
	media-plugins/gst-plugins-libav
	>=app-text/gspell-1.0
"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
"

src_configure() {
	local emesonargs=(
		-Dconsumer_key_base64=VmY5dG9yRFcyWk93MzJEZmhVdEk5Y3NMOA==
		-Dconsumer_secret_base64=MThCRXIxbWRESDQ2Y0podzVtVU13SGUyVGlCRXhPb3BFRHhGYlB6ZkpybG5GdXZaSjI=
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}
