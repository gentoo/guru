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
IUSE="qt5 qt6 test"
REQUIRED_USE="|| ( qt5 qt6 )"

COMMON_DEPEND="
	qt5? (
		dev-libs/msgpack:=
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtsvg:5
		dev-qt/qtwidgets:5
	)
	qt6? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qtsvg:5
	)
"
# NOTE: see <https://github.com/equalsraf/neovim-qt/issues/1005> for dejavu dep
DEPEND="
	${COMMON_DEPEND}
	test? (
		qt5? ( dev-qt/qttest:5 )
		media-fonts/dejavu[X]
	)
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
		-DQT_VERSION_MAJOR=$(usex qt5 5 6)
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
