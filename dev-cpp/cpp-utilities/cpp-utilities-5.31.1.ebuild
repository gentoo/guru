# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Useful C++ classes and routines"
HOMEPAGE="https://github.com/Martchus/cpp-utilities"

SRC_URI="https://github.com/Martchus/cpp-utilities/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DEXCLUDE_TESTS_FROM_ALL=$(usex !test)
	)
	cmake_src_configure
}
