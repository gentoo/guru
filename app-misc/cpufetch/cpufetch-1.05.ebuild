# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Simplistic yet fancy CPU architecture fetching tool"
HOMEPAGE="https://github.com/Dr-Noob/cpufetch"
SRC_URI="https://github.com/Dr-Noob/cpufetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64"

PATCHES=( "${FILESDIR}/${P}-respect-ldflags.patch" )

src_prepare() {
	default
	tc-export CC
}

src_install() {
	dobin "${PN}"
	doman "${PN}.1"
	newdoc README.md README
	dodoc -r doc/.
}
