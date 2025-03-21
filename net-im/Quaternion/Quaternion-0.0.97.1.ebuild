# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="A Qt-based IM client for Matrix"
HOMEPAGE="https://github.com/quotient-im/Quaternion https://matrix.org/ecosystem/clients/quaternion/"
GITHUB_PV=${PV//_/-}
SRC_URI="https://github.com/quotient-im/${PN}/archive/refs/tags/${GITHUB_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${GITHUB_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-qt/qtbase:6[widgets,network,gui]
	dev-qt/qttools:6[linguist]
	dev-qt/qtdeclarative:6[widgets]
	>=net-libs/libquotient-0.9.0:=
	<net-libs/libquotient-0.10.0
	dev-libs/qtkeychain:=[qt6]
"
DEPEND="
	${RDEPEND}
	dev-qt/qtmultimedia:6
"
BDEPEND="
	dev-qt/qttools:6[linguist]
"

DOCS=( {README,SECURITY}.md )

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
