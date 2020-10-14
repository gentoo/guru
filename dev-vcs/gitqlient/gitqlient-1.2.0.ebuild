# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg

MY_PN="GitQlient"
QLogger_sha="d33cb645bb6ffc4dd929c348ca011c007351d605"

DESCRIPTION="Multi-platform Git client written with Qt"
HOMEPAGE="https://github.com/francescmm/GitQlient"

SRC_URI="
	https://github.com/francescmm/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/francescmm/QLogger/archive/d33cb645bb6ffc4dd929c348ca011c007351d605.tar.gz -> QLogger-d33cb64.tar.gz
"
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtgui:5
"

RDEPEND="
	${DEPEND}
	dev-vcs/git
"

src_prepare() {
	default
	mv -T "${WORKDIR}"/QLogger-"${QLogger_sha}" "${S}"/QLogger || die

	sed -i -e "s:target.path = /\$\$(HOME)/\$\${TARGET}/bin:target.path = /usr/bin:" \
	-i -e "s:TARGET = ${MY_PN}:TARGET = ${PN}:" "${MY_PN}".pro || die

	sed -i -e "s:Office:Development:" -i -e "s:Exec=${MY_PN}:Exec=${PN}:" \
	"${S}/AppImage/${MY_PN}/usr/share/applications/${MY_PN}.desktop" || die
}

src_configure() {
	eqmake5 "${MY_PN}".pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	domenu "${S}/AppImage/${MY_PN}/usr/share/applications/${MY_PN}.desktop" || die
	doicon -s 48 "${S}/AppImage/${MY_PN}/usr/share/icons/hicolor/48x48/apps/${MY_PN}.png" || die
}
