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

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" INSTALL="install -D" PREFIX="${EPREFIX}/usr" install
}
