# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Lossless video/audio editing: export media without reencoding, powered by ffmpeg"
HOMEPAGE="https://mifi.no/losslesscut/
https://github.com/mifi/lossless-cut"
SRC_URI="https://github.com/mifi/lossless-cut/releases/download/v${PV}/LosslessCut-linux-x86_64.AppImage
	-> ${P}.AppImage
https://raw.githubusercontent.com/mifi/lossless-cut/v${PV}/no.mifi.losslesscut.appdata.xml
-> ${P}-metainfo.xml
"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="disable-networking system-ffmpeg"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	sys-fs/fuse:0
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	system-ffmpeg? ( media-video/ffmpeg )
"

QA_PREBUILT="usr/bin/losslesscut-bin"

src_install() {
	# keep this in sync with the Exec value in the desktop file
	newbin "${DISTDIR}"/${P}.AppImage losslesscut-bin

	local desktop_file="${WORKDIR}"/no.mifi.losslesscut.desktop
	cp "${FILESDIR}"/no.mifi.losslesscut.desktop "${desktop_file}" || die
	if use disable-networking; then
		sed -i "/^Exec=/ s%$% --disable-networking%" "${desktop_file}" || die
	fi
	if use system-ffmpeg; then
		sed -i "/^Exec=/ s%$% --settings-json '{\"customFfPath\": \"/usr/bin\"}'%" "${desktop_file}" || die
	fi
	domenu "${desktop_file}"
	doicon "${FILESDIR}"/no.mifi.losslesscut.svg

	insinto /usr/share/metainfo
	newins "${DISTDIR}"/${P}-metainfo.xml no.mifi.losslesscut.appdata.xml
}
