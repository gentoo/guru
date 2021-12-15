# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils xdg

MY_PN="GitQlient"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"

#EGIT_BRANCH="develop"
EGIT_REPO_URI="https://github.com/francescmm/${MY_PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebchannel:5
	dev-qt/qtwebengine:5[widgets]
	dev-qt/qtwidgets:5
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"

src_prepare() {
	default
	sed -i -e "/QMAKE_CXXFLAGS/s:-Werror::" "${MY_PN}".pro || die

	sed -i -e "s:Office:Development:" "${S}/src/resources/${PN}.desktop" || die
}

src_configure() {
	eqmake5 PREFIX=/usr "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
