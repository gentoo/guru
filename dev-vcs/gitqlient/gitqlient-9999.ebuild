# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 optfeature qmake-utils xdg

MY_PN="GitQlient"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"
EGIT_REPO_URI="https://github.com/francescmm/${MY_PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
RDEPEND="
	${DEPEND}
	dev-vcs/git
"

src_configure() {
	eqmake5 PREFIX=/usr "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	optfeature "Terminal tab plugin support" x11-libs/qtermwidget
	optfeature "GitServer plugin support" dev-vcs/gitqlient-gitserver-plugin
	optfeature "Jenkins plugin support"  dev-vcs/gitqlient-jenkins-plugin
	elog "To use plugins set PluginFolder in GitQlient settings Plugin tab to /usr/$(get_libdir)"
	xdg_pkg_postinst
}
