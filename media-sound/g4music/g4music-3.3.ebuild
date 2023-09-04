# Copyright 2023 Gentoo Authors
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

IDEPEND=""
DEPEND="
		>=gui-libs/gtk-4.6
		>=gui-libs/libadwaita-1
		>=media-libs/gstreamer-1.20.6[introspection]
		>=media-plugins/gst-plugins-taglib-1.20.6
		>=dev-libs/appstream-glib-0.8.2
		pipewire? ( media-video/pipewire[gstreamer] )
"
RDEPEND="${DEPEND}"
BDEPEND="
		>=dev-util/meson-1.1.1
		>=dev-lang/vala-0.56.8
		$(vala_depend)
"

src_prepare() {
	default
	vala_setup
	xdg_environment_reset

	sed -i \
		-e '/^gnome.post_install(/,/)/d' \
		meson.build \
		|| die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
