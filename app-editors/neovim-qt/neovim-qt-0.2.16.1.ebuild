# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Neovim client library and GUI, in Qt5"
HOMEPAGE="https://github.com/equalsraf/neovim-qt"
SRC_URI="https://github.com/equalsraf/neovim-qt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gcov"

DEPEND="
	dev-libs/msgpack
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	app-editors/neovim"

src_configure() {
	local mycmakeargs=(
		-DUSE_GCOV=$(usex gcov ON OFF)
		-DUSE_SYSTEM_MSGPACK=ON
	)

	cmake_src_configure
}
