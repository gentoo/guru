# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils

DESCRIPTION="Application for browsing your local Portage repository files"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtsql[sqlite]
"

RDEPEND="
	app-portage/gentoolkit
	app-portage/portage-utils
	lxde-base/lxterminal
	${DEPEND}
"

src_configure() {
	eqmake5
}

src_install() {
	mv AppSwipe appswipe
	dobin appswipe
	mv "${S}/img/appicon.svg" "${S}/img/appswipe.svg"
	doicon -s scalable "${S}/img/appswipe.svg"
	domenu ${PN}.desktop
}
