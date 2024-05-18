# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="End-to-end encrypted note taking alternative to Evernote"
HOMEPAGE="https://notesnook.com/"
SRC_URI="https://github.com/streetwriters/notesnook/releases/download/v${PV}/notesnook_linux_x86_64.AppImage"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/notesnook_linux_x86_64.AppImage" notesnook-bin
}
