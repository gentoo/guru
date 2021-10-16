# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Simplistic yet fancy CPU architecture fetching tool"
HOMEPAGE="https://github.com/Dr-Noob/cpufetch"
SRC_URI="https://github.com/Dr-Noob/cpufetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_prepare() {
	default
	export CC=$(tc-getCC)
}

src_install() {
	dobin "${PN}"
	doman "${PN}.1"
	newdoc README.md README
	dodoc -r doc/.
}
