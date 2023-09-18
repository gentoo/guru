# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Qt-based IM client for Matrix"
HOMEPAGE="https://github.com/quotient-im/Quaternion https://matrix.org/ecosystem/clients/quaternion/"
GITHUB_PV=${PV//_/-}
SRC_URI="https://github.com/quotient-im/${PN}/archive/refs/tags/${GITHUB_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${GITHUB_PV}"

RDEPEND="
	>=dev-qt/qtcore-5.15.0:5
	>=dev-qt/qtdeclarative-5.15.0:5[widgets(+)]
	>=dev-qt/qtgui-5.15.0:5
	>=dev-qt/qtnetwork-5.15.0:5
	>=dev-qt/qtquickcontrols2-5.15.0:5[widgets(+)]
	>=dev-qt/qtwidgets-5.15.0:5
	>=net-libs/libquotient-0.8.0:=[qt5(+)]
	dev-libs/qtkeychain:=[qt5]
"
DEPEND="
	${RDEPEND}
	>=dev-qt/qtdbus-5.15.0
	>=dev-qt/qtmultimedia-5.15.0:5
"
BDEPEND="
	>=dev-qt/linguist-tools-5.15.0:5
"

DOCS=( {README,SECURITY}.md )

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QT6=NO
	)

	cmake_src_configure
}
