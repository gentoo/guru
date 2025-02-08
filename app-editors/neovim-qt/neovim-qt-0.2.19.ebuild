# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake virtualx xdg

DESCRIPTION="Neovim client library and GUI, in Qt"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
SRC_URI="https://github.com/equalsraf/neovim-qt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-libs/msgpack:=
	dev-qt/qtbase:6[gui,network,widgets]
	dev-qt/qtsvg:6
"
# NOTE: see <https://github.com/equalsraf/neovim-qt/issues/1005> for dejavu dep
DEPEND="
	${COMMON_DEPEND}
	test? ( media-fonts/dejavu[X] )
"
RDEPEND="
	${COMMON_DEPEND}
	app-editors/neovim
"

src_configure() {
	local mycmakeargs=(
		-DREPRODUCIBLE_BUILD=ON
		-DUSE_SYSTEM_MSGPACK=ON
		-DUSE_GCOV=OFF
		-DENABLE_TESTS=$(usex test)
		-DBUILD_SHARED_LIBS=OFF # upstream explicitly builds static lib
		-DWITH_QT=Qt6
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
