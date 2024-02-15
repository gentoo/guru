# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast, disk space efficient package manager, alternative to npm and yarn"
HOMEPAGE="https://pnpm.io"

SRC_URI="https://github.com/pnpm/pnpm/releases/download/v${PV}/pnpm-linux-x64"
KEYWORDS="~amd64"

LICENSE="MIT"
SLOT="0"

RESTRICT="strip"

S="${WORKDIR}"

QA_PREBUILT="/usr/bin/${PN}-bin"

src_install() {
	newbin "${DISTDIR}/pnpm-linux-x64" ${PN}
}
