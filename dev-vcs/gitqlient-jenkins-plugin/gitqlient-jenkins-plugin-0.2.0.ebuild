# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

MY_PN="JenkinsPlugin"
GQ="GitQlient"
GQ_PN="gitqlient"
GQ_PV="1.6.1"

DESCRIPTION="GitQlient Jenkins plugin"
HOMEPAGE="https://github.com/francescmm/JenkinsPlugin"
SRC_URI="
	https://github.com/francescmm/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${GQ_PN}-${MY_PN}-${PV}.tar.gz
	https://github.com/francescmm/${GQ}/releases/download/v${GQ_PV}/${GQ_PN}_${GQ_PV}.tar.gz -> ${GQ_PN}-${GQ_PV}.tar.gz
"

KEYWORDS="~amd64"
LICENSE="LGPL-2.1"
SLOT="0"

S="${WORKDIR}/${MY_PN}-${PV}"

PDEPEND=">=dev-vcs/gitqlient-1.6.1"
RDEPEND="
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebengine:5[widgets]
"
DEPEND="${DEPEND}"

# No need SONAME for runtime plugin
QA_SONAME="usr/lib.*/lib${MY_PN}.so"

src_prepare() {
	default

	mv -T ../"${GQ_PN}_${GQ_PV}"/src/AuxiliarCustomWidgets src/AuxiliarCustomWidgets || die
	mv -T ../"${GQ_PN}_${GQ_PV}"/src/QLogger src/QLogger || die
	mv -T ../"${GQ_PN}_${GQ_PV}"/src/QPinnableTabWidget src/QPinnableTabWidget || die
}

src_configure() {
	eqmake5 "${MY_PN}".pro
}

src_install() {
	dolib.so lib/lib"${MY_PN}".so
}

pkg_postinst() {
	elog "To use ${MY_PN} set PluginFolder in GitQlient settings Plugin tab to /usr/$(get_libdir)"
}
