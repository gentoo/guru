# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="TOML for Modern C++"
HOMEPAGE="https://github.com/ToruNiina/toml11"
SRC_URI="https://github.com/ToruNiina/toml11/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/doctest )"

PATCHES=(
	# unbundle doctest
	"${FILESDIR}/${PN}-4.1.0-system-doctest.patch"
	# unset Werror
	"${FILESDIR}/${PN}-4.1.0-werror.patch"
)

src_configure() {
	local mycmakeargs=(
		-DTOML11_BUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}
