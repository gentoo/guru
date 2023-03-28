# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Note taking app, on Electron, can import notes from Evernote"
HOMEPAGE="https://joplinapp.org"

SRC_URI="https://github.com/laurent22/joplin/releases/download/v${PV}/Joplin-${PV}.AppImage"
KEYWORDS="~amd64"

LICENSE="AGPL-3"
SLOT="0"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"
S="${WORKDIR}"

src_install() {
	cp "${DISTDIR}/Joplin-${PV}.AppImage" joplin-bin || die
	dobin joplin-bin
}
