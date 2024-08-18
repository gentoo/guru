# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake virtualx xdg

DESCRIPTION="Neovim client library and GUI, in Qt"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
SRC_URI="https://github.com/equalsraf/neovim-qt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt6 test"

COMMON_DEPEND="
	dev-libs/msgpack:=
	!qt6? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qtsvg:6
	)
"
# NOTE: see <https://github.com/equalsraf/neovim-qt/issues/1005> for dejavu dep
DEPEND="
	${COMMON_DEPEND}
	!qt6? ( dev-qt/qttest:5 )
	test? ( media-fonts/dejavu[X] )
"
RDEPEND="
	${COMMON_DEPEND}
	app-editors/neovim"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_MSGPACK=ON
		-DUSE_GCOV=OFF
		-DENABLE_TESTS=$(usex test)
		-DBUILD_SHARED_LIBS=OFF # upstream explicitly builds static lib
		-DWITH_QT=$(usex qt6 Qt6 Qt5)
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
