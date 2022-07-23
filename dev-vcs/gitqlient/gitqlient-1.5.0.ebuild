# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature qmake-utils xdg

MY_PN="GitQlient"
MY_PV=$(ver_rs 3 -)

# subprojects on GitQlient 1.5 release:
AuxiliarCustomWidgets_SHA="835f538b4a79e4d6bb70eef37a32103e7b2a1fd1"
QLogger_SHA="d1ed24e080521a239d5d5e2c2347fe211f0f3e4f"
QPinnableTabWidget_SHA="cc937794e910d0452f0c07b4961c6014a7358831"
git_SHA="b62750f4da4b133faff49e6f53950d659b18c948"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"

SRC_URI="
	https://github.com/francescmm/${MY_PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/francescmm/AuxiliarCustomWidgets/archive/${AuxiliarCustomWidgets_SHA}.tar.gz -> ${P}_AuxiliarCustomWidgets.tar.gz
	https://github.com/francescmm/QLogger/archive/${QLogger_SHA}.tar.gz -> ${P}_QLogger.tar.gz
	https://github.com/francescmm/QPinnableTabWidget/archive/${QPinnableTabWidget_SHA}.tar.gz -> ${P}_QPinnableTabWidget.tar.gz
	https://github.com/francescmm/git/archive/${git_SHA}.tar.gz -> ${P}_git.tar.gz
	"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

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
	mv -T "${WORKDIR}"/AuxiliarCustomWidgets-"${AuxiliarCustomWidgets_SHA}" "${S}"/src/AuxiliarCustomWidgets || die
	mv -T "${WORKDIR}"/QLogger-"${QLogger_SHA}" "${S}"/src/QLogger || die
	mv -T "${WORKDIR}"/QPinnableTabWidget-"${QPinnableTabWidget_SHA}" "${S}"/src/QPinnableTabWidget || die
	mv -T "${WORKDIR}"/git-"${git_SHA}" "${S}"/src/git || die

	default
	sed -i -e "/QMAKE_CXXFLAGS/s:-Werror::" -e "/^GQ_SHA/d" "${MY_PN}".pro || die
	sed -i -e "s:Office:Development:" "${S}/src/resources/${PN}.desktop" || die
}

src_configure() {
	eqmake5 PREFIX=/usr "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	optfeature "Jenkins and/or GitServer plugins support" dev-qt/qtwebchannel:5 dev-qt/qtwebengine:5[widgets]
}
