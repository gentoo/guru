# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="End-to-end encrypted note-taking app, alternative to Evernote"
HOMEPAGE="https://standardnotes.com"

SRC_URI="https://github.com/standardnotes/app/releases/download/%40standardnotes%2Fdesktop%40${PV}/standard-notes-${PV}-linux-x86_64.AppImage"
KEYWORDS="~amd64"

LICENSE="AGPL-3"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/standard-notes-${PV}-linux-x86_64.AppImage" standard-notes-bin
}
