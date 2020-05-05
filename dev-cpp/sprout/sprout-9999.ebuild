# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="C++11/14 constexpr based Containers, Algorithms, Random numbers and others"
HOMEPAGE="http://bolero-murakami.github.io/Sprout/"
EGIT_REPO_URI="https://github.com/bolero-MURAKAMI/Sprout.git"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS=""

IUSE="test texconv wavconv"
RESTRICT="!test? ( test )"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/optional_binaries.patch
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test ON OFF)
		-DWITH_TEXCONV=$(usex texconv ON OFF)
		-DWITH_WAVCONV=$(usex wavconv ON OFF)
	)
	cmake_src_configure
}
