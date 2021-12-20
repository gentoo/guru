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
IUSE="+X gstreamer spell"

DEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	net-libs/libsoup:2.4
	net-libs/liboauth
	media-plugins/gst-plugins-libav
	sys-devel/gettext
	x11-libs/gtk+:3
	X? ( x11-libs/libX11 )
	gstreamer? (
		media-libs/gst-plugins-base
		media-libs/gst-plugins-bad
	)
	spell? ( app-text/gspell )
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	dev-libs/gobject-introspection
"

src_configure() {
	local emesonargs=(
		$(meson_use X x11)
		$(meson_use gstreamer video)
		$(meson_use spell spellcheck)
		-Dconsumer_key_base64=VmY5dG9yRFcyWk93MzJEZmhVdEk5Y3NMOA==
		-Dconsumer_secret_base64=MThCRXIxbWRESDQ2Y0podzVtVU13SGUyVGlCRXhPb3BFRHhGYlB6ZkpybG5GdXZaSjI=
	)
	meson_src_configure
}
