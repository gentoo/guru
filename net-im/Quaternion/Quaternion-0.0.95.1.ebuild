# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Qt-based IM client for Matrix"
HOMEPAGE="https://github.com/quotient-im/Quaternion https://matrix.org/docs/projects/client/quaternion.html"
SRC_URI="https://github.com/quotient-im/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+keychain"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5[widgets(+)]
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtquickcontrols2:5[widgets(+)]
	dev-qt/qtwidgets:5
	>=net-libs/libquotient-0.5.1:=
	keychain? ( dev-libs/qtkeychain:= )
"
DEPEND="
	${RDEPEND}
	dev-qt/qtdbus:5
	dev-qt/qtmultimedia:5
"
BDEPEND="dev-qt/linguist-tools:5"

DOCS=( {README,SECURITY}.md )

src_configure() {
	local mycmakeargs=(
		-DUSE_KEYCHAIN=$(usex keychain)
	)

	cmake_src_configure
}
