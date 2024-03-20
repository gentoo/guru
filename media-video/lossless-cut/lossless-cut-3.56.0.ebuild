# Copyright 1999-2024 Gentoo Authors
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
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0
sys-libs/zlib:=
"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/losslesscut-bin"

src_install() {
	# keep this in sync with the Exec value in the desktop file
	newbin "${DISTDIR}"/${P}.AppImage losslesscut-bin

	domenu "${FILESDIR}"/no.mifi.losslesscut.desktop
	doicon "${FILESDIR}"/no.mifi.losslesscut.svg

	insinto /usr/share/metainfo
	newins "${DISTDIR}"/${P}-metainfo.xml no.mifi.losslesscut.appdata.xml
}
