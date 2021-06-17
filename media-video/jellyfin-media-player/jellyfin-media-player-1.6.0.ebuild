# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg unpacker

MY_PV="${PV}-1"

DESCRIPTION="Jellyfin Desktop Client based on Plex Media Player"
HOMEPAGE="https://github.com/jellyfin/jellyfin-media-player"
SRC_URI="https://github.com/jellyfin/${PN}/releases/download/v${PV}/${PN}_${MY_PV}_amd64-groovy.deb -> ${P}.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libcec
	dev-qt/qtquickcontrols2
	dev-qt/qtwebchannel
	dev-qt/qtwebengine
	dev-qt/qtx11extras
	media-video/mpv[libmpv]
"

QA_PREBUILT=".*"

S="${WORKDIR}"

src_install() {
	doins -r usr
	fperms +x /usr/bin/jellyfinmediaplayer
	rm -r "${ED}"/usr/share/doc/ || die
}
