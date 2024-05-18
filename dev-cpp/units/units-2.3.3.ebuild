# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A compile-time, header-only, dimensional analysis and unit conversion library"
HOMEPAGE="https://github.com/nholthaus/units"
SRC_URI="https://github.com/nholthaus/units/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

PATCHES=(
	"${FILESDIR}/${P}-disable-failing-tests.patch"
)

src_configure() {
	local mycmakeargs+=(
		-DBUILD_TESTS="$(usex test ON OFF)"
	)
	cmake_src_configure
}
