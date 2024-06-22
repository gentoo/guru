# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="S* Floating Window Bar"
HOMEPAGE="https://github.com/LBCrion/sfwbar"
SRC_URI="https://github.com/LBCrion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="X mpd pulseaudio alsa"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/json-c:=
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	>=x11-libs/gtk+-3.22.0:3[introspection,wayland]
	X? ( x11-libs/libxkbcommon )
	mpd? ( media-libs/libmpdclient )
	pulseaudio? ( media-libs/libpulse[glib] )
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${COMMON_DEPEND}
	virtual/freedesktop-icon-theme
"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/wayland-protocols-1.17
"
BDEPEND="dev-util/wayland-scanner"

src_configure() {
	local emesonargs=(
		$(meson_feature alsa)
		$(meson_feature mpd)
		$(meson_feature pulseaudio pulse)
		$(meson_feature X xkb)
		-Dnetwork=enabled
		-Didleinhibit=enabled
		-Dbluez=enabled
		-Dbsdctl=disabled
		-Diwd=enabled
	)

	meson_src_configure
}
