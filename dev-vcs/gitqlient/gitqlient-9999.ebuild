# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils xdg

MY_PN="GitQlient"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"
EGIT_REPO_URI="https://github.com/francescmm/${MY_PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="dev-qt/qtbase:6[gui,network,widgets]"
RDEPEND="
	${DEPEND}
	dev-vcs/git
"

src_configure() {
	eqmake6 PREFIX=/usr "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_pkg_postinst
}
