# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Lossless video/audio editing: export media without reencoding, powered by ffmpeg"
HOMEPAGE="https://mifi.no/losslesscut/
https://github.com/mifi/lossless-cut"

SRC_URI="https://github.com/mifi/lossless-cut/releases/download/v${PV}/LosslessCut-linux-x86_64.AppImage
	-> ${P}.AppImage
"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0
sys-libs/zlib:=
"

QA_PREBUILT="usr/bin/losslesscut-bin"

src_unpack() {
	unpack "${FILESDIR}"/${P}-misc.tar.xz
}

src_prepare() {
	default
	# Fix XDG desktop entry Exec
	sed -i -e 's,/app/bin/run.sh,losslesscut-bin,' \
		no.mifi.losslesscut.desktop || die
}

src_install() {
	newbin "${DISTDIR}"/${P}.AppImage losslesscut-bin
	domenu no.mifi.losslesscut.desktop
	doicon no.mifi.losslesscut.svg

	insinto /usr/share/metainfo
	doins no.mifi.losslesscut.appdata.xml
}
