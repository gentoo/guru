# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson gnome2-utils

MY_PV=${PV//_/.}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Matrix group messaging app"
HOMEPAGE="https://wiki.gnome.org/Apps/Fractal"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.gnome.org/world/fractal.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${MY_PV}/${MY_P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=dev-libs/glib-2.72
	>=app-text/gspell-1.8.1
	>=gui-libs/libadwaita-1.3
	>=media-libs/gstreamer-1.20
	>=media-libs/gst-plugins-base-1.20
	>=dev-db/sqlite-3.24
	>=media-video/pipewire-0.3[gstreamer]
	>=media-libs/libshumate-1
	>=x11-libs/cairo-1.16.0
	>=gui-libs/gtk-4.10:4
	gui-libs/gtksourceview:5
	media-plugins/gst-plugins-gtk"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/ninja
	dev-util/meson
	>=virtual/rust-1.31.1"

S=${WORKDIR}/${MY_P}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
