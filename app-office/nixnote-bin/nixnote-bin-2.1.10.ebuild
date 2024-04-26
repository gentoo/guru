# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Free and open source note taking app, compatible with Evernote sync server"
HOMEPAGE="https://github.com/robert7/nixnote2"
SRC_URI="https://github.com/robert7/nixnote2/releases/download/v${PV}/NixNote2-x86_64.AppImage"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/NixNote2-x86_64.AppImage" nixnote-bin
}
