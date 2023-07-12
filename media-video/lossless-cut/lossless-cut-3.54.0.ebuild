# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Lossless video/audio editing: export media without reencoding, powered by ffmpeg"
HOMEPAGE="https://github.com/mifi/lossless-cut"

SRC_URI="https://github.com/mifi/lossless-cut/releases/download/v${PV}/LosslessCut-linux-x86_64.AppImage"
KEYWORDS="~amd64"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/LosslessCut-linux-x86_64.AppImage" losslesscut-bin
}
