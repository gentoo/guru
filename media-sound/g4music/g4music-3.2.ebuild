# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg gnome2-utils vala

DESCRIPTION="A GTK4 music player"
HOMEPAGE="https://gitlab.gnome.org/neithern/g4music"
SRC_URI="https://gitlab.gnome.org/neithern/g4music/-/archive/v${PV}/g4music-v${PV}.tar.bz2"
S="${WORKDIR}/g4music-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="pipewire"

IDEPEND=">=gui-libs/gtk-4.6
>=gui-libs/libadwaita-1
>=media-libs/gstreamer-1.20.6[introspection]
>=dev-lang/vala-0.56.8
pipewire? ( media-video/pipewire[gstreamer] )"
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="$(vala_depend)"

src_prepare() {
	default
	vala_setup
	xdg_environment_reset
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
