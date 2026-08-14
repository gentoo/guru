# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Application for browsing your local Portage repository files"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtbase:6[gui,sql,sqlite,widgets]
	dev-qt/qtsvg:6
"

RDEPEND="
	app-portage/gentoolkit
	app-portage/portage-utils
	dev-libs/glib
	lxde-base/lxterminal
	sys-apps/portage
	${DEPEND}
"

src_configure() {
	eqmake6 AppSwipe.pro

	cd backend || die
	eqmake6 appswipebackend.pro

	cd ../transport || die
	eqmake6 appswipetransport.pro
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
