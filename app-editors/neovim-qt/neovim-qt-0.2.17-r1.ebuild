# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake virtualx xdg

DESCRIPTION="Neovim client library and GUI, in Qt5"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
SRC_URI="https://github.com/equalsraf/neovim-qt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

COMMON_DEPEND="
	dev-libs/msgpack:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
"
# NOTE: remove dejavu once <https://github.com/equalsraf/neovim-qt/issues/1005>
#       is resolved
DEPEND="
	${COMMON_DEPEND}
	test? (
		dev-qt/qttest:5
		media-fonts/dejavu[X]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	app-editors/neovim"

RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}"/${P}-only-require-Qt5Test-if-tests-are-enabled.patch
	"${FILESDIR}"/${P}-fix-finding-msgpack-6+.patch
)
src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_MSGPACK=ON
		-DUSE_GCOV=OFF
		-DENABLE_TESTS=$(usex test)
		-DBUILD_SHARED_LIBS=OFF # upstream explicitly builds static lib
	)

	cmake_src_configure
}

src_test() {
	virtx cmake_src_test
}
