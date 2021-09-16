# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A Qt5 library to write cross-platfrom clients for Matrix"
HOMEPAGE="https://github.com/QMatrixClient/libqmatrixclient https://matrix.org/docs/projects/sdk/libqmatrixclient.html"
SRC_URI="https://github.com/QMatrixClient/libqmatrixclient/archive/${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0/0.5.3"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtnetwork:5=
	dev-qt/qtgui:5=
	dev-qt/qtmultimedia:5=
"

S="${WORKDIR}/libQuotient-${PV}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_INCLUDEDIR=include/libqmatrixclient
	)

	cmake_src_configure
}
