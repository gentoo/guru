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
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"

RDEPEND="
	app-portage/gentoolkit
	app-portage/portage-utils
	lxde-base/lxterminal
	${DEPEND}
"

src_configure() {
	eqmake5 AppSwipe.pro

	cd backend || die
	eqmake5 appswipebackend.pro

	cd ../transport || die
	eqmake5 appswipetransport.pro
}

src_compile() {
	emake -C ./
	emake -C backend/
	emake -C transport/
}

src_install() {
	newbin AppSwipe appswipe
	dobin backend/appswipebackend
	dobin transport/appswipetransport
	newicon -s scalable img/appicon.svg ${PN}.svg
	domenu ${PN}.desktop
}
