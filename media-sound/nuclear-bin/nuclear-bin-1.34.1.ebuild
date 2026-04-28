# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit unpacker desktop xdg

MY_P="nuclear-v${PV}"

DESCRIPTION="Streaming music player that finds free music for you"
HOMEPAGE="https://nuclearplayer.com"
SRC_URI="https://github.com/nukeop/nuclear/releases/download/player@${PV}/Nuclear_${PV}_amd64.deb -> ${P}.deb"

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa[opengl]
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo[X]
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango[X]
"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb "${P}.deb"
}

src_install(){
	dobin "usr/bin/nuclear-music-player"
	domenu "usr/share/applications/Nuclear.desktop"
	doicon --size 512 "usr/share/icons/hicolor/512x512/apps/nuclear-music-player.png"
}
