# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="Visual Voicemail Player"
HOMEPAGE="https://gitlab.com/kop316/vvmplayer"
SRC_URI="https://gitlab.com/kop316/vvmplayer/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-libs/glib-2.50:2
	gnome-extra/evolution-data-server:=
	>=gui-libs/libhandy-1.0:1
	media-libs/gst-plugins-base:1.0
	>=media-libs/gstreamer-1.16.0:1.0
	media-sound/callaudiod
	net-voip/vvmd
	>=x11-libs/gtk+-3.22.0:3
"
DEPEND="${RDEPEND}"

PATCHES=(
	# requires network access
	"${FILESDIR}/${P}-skip-appstream-validation.patch"
)

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
