# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils xdg

DESCRIPTION="Visual cross-platform gemini browser"
HOMEPAGE="https://github.com/MasterQ32/kristall"
SRC_URI="https://github.com/MasterQ32/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5[ssl]
"
DEPEND="${RDEPEND}"

src_configure() {
	# qmake overwrites Makefile but it is needed for installing.
	mv Makefile{,.tmp} || die
	eqmake5 src/kristall.pro
}

src_install() {
	mv Makefile{.tmp,} || die
	INSTALL="install -D" PREFIX="${EPREFIX}/usr" default
}
