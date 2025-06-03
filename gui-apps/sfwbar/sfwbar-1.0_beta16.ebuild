# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="S* Floating Window Bar"
HOMEPAGE="https://github.com/LBCrion/sfwbar"
if [ "${PV}" == 9999 ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LBCrion/${PN}"
else
	SRC_URI="https://github.com/LBCrion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
LICENSE="GPL-3"
SLOT="0"

IUSE="+menu X mpd pulseaudio alsa network networkmanager iwd bluetooth notification man idleinhibit bsdctl"

COMMON_DEPEND="
	dev-libs/glib:2
	dev-libs/json-c:=
	dev-libs/wayland
	<=gui-libs/gtk-layer-shell-0.9.1
	>=x11-libs/gtk+-3.22.0:3[introspection,wayland]
	X? ( x11-libs/libxkbcommon )
	mpd? ( media-libs/libmpdclient )
	pulseaudio? ( media-libs/libpulse[glib] )
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="${COMMON_DEPEND}
	virtual/freedesktop-icon-theme
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/pango
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
		$(meson_feature network)
		$(meson_feature networkmanager nm)
		$(meson_feature iwd)
		$(meson_feature menu appmenu)
		$(meson_feature bluetooth bluez)
		$(meson_feature bsdctl)
		$(meson_feature notification ncenter)
		$(meson_feature notification idle)
		$(meson_feature man build-docs)
		$(meson_feature idleinhibit)
	)

	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
