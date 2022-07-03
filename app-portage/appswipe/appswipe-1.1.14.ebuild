# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Application for browsing your local Portage repository files"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtsql[sqlite]
	dev-qt/qtwidgets
"

RDEPEND="${DEPEND}
	app-portage/gentoolkit
	app-portage/portage-utils
	lxde-base/lxterminal
"

src_configure() {
	eqmake5
}

src_install() {
	newbin AppSwipe appswipe
	newicon -s scalable img/appicon.svg ${PN}.svg
	domenu ${PN}.desktop
}
