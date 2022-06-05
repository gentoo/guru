# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for the creation and manipulation of lists"
HOMEPAGE="https://github.com/GTkorvo/atl"
SRC_URI="https://github.com/GTKorvo/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +utilities"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DATL_INSTALL_HEADERS=ON
		-DATL_INSTALL_PKGCONFIG=ON
		-DATL_QUIET=OFF
		-DBUILD_SHARED_LIBS=ON

		-DATL_LIBRARIES_ONLY=$(usex utilities 'OFF' 'ON')
		-DBUILD_TESTING=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
}
