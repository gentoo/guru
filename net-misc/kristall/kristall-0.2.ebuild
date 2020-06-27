# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg

DESCRIPTION="Visual cross-platform gemini browser"
HOMEPAGE="https://github.com/MasterQ32/kristall"
SRC_URI="https://github.com/MasterQ32/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtmultimedia[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5[ssl]
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -Ei 's|(target\.path) = .+|\1 = /usr/bin|' src/kristall.pro || die
}

src_configure() {
	eqmake5 src/kristall.pro
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	einstalldocs

	doicon src/icons/kristall.svg
	domenu Kristall.desktop
}
