# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Screen sharing for terminal: ASCII in browser or terminal, without pixels moving"
HOMEPAGE="https://github.com/elisescu/tty-share"
SRC_URI="https://github.com/elisescu/tty-share/releases/download/v${PV}/tty-share_linux-amd64"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip"

QA_PREBUILT="usr/bin/${PN}"

src_install() {
	newbin "${DISTDIR}/tty-share_linux-amd64" ${PN}
}
