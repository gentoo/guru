# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="8f2f3d3a1652b87162f763a88a5070cf25c2e6d7"
DESCRIPTION="Simplistic yet fancy CPU architecture fetching tool"
HOMEPAGE="https://github.com/Dr-Noob/cpufetch"
SRC_URI="https://github.com/Dr-Noob/cpufetch/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
PATCHES=( "${FILESDIR}/makefile-${PV}.patch" )
S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin "${PN}"
	doman "${PN}.8"
	newdoc README.md README
	dodoc -r doc/.
}
