# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

DESCRIPTION="Diagram drawing application built on web technologies"
HOMEPAGE="https://github.com/jgraph/drawio-desktop"

SRC_URI="https://github.com/jgraph/${MY_PN}/releases/download/v${PV}/drawio-x86_64-${PV}.AppImage"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="strip"

RDEPEND="sys-fs/fuse:0"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	newbin "${DISTDIR}/drawio-x86_64-21.6.5.AppImage" drawio-appimage
}
