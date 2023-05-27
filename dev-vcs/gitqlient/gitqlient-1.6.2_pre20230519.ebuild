# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature qmake-utils xdg

MY_PN="GitQlient"
gitqlient_sha="5a6175431261b99c0f9c37e2194f92a8bafe29f9"
AuxiliarCustomWidgets_sha="f86e72abd442f73b1e3b10ac922908d03444f115"
QLogger_sha="ce2f35bad6440a14802fed6c043323d4227ef9a9"
QPinnableTabWidget_sha="40d0a02e5bdf2f49f9ea41ca533093b2808b0140"
git_sha="fd6588d07bcbf77c86265392809b9a92ee3f8189"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"

SRC_URI="
	https://github.com/francescmm/${MY_PN}/archive/${gitqlient_sha}.tar.gz -> ${P}.tar.gz
	https://github.com/francescmm/AuxiliarCustomWidgets/archive/${AuxiliarCustomWidgets_sha}.tar.gz \
		-> ${P}_AuxiliarCustomWidgets.tar.gz
	https://github.com/francescmm/QLogger/archive/${QLogger_sha}.tar.gz -> ${P}_QLogger.tar.gz
	https://github.com/francescmm/QPinnableTabWidget/archive/${QPinnableTabWidget_sha}.tar.gz \
		-> ${P}_QPinnableTabWidget.tar.gz
	https://github.com/francescmm/git/archive/${git_sha}.tar.gz -> ${P}_git.tar.gz
"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_PN}-${gitqlient_sha}"

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

src_prepare() {
	default

	mv -T "${WORKDIR}/AuxiliarCustomWidgets-${AuxiliarCustomWidgets_sha}" "${S}/src/AuxiliarCustomWidgets" || die
	mv -T "${WORKDIR}/QLogger-${QLogger_sha}" "${S}/src/QLogger" || die
	mv -T "${WORKDIR}/QPinnableTabWidget-${QPinnableTabWidget_sha}" "${S}/src/QPinnableTabWidget" || die
	mv -T "${WORKDIR}/git-${git_sha}" "${S}/src/git" || die

	# Drop 'fatal' warning on version detection via git command:
	sed -i -e '/message("Submodule update:")/d' \
		-e "/system(git submodule update --init --recursive)/d" \
		-e "/GQ_SHA =/s| \$\$system(git rev-parse --short HEAD)||" \
		-e "/VERSION =/s| \$\$system(git describe --abbrev=0)||" "${MY_PN}".pro || die
}

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
