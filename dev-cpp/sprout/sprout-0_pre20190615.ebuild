# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="6b5addba9face0a6403e66e7db2aa94d87387f61"

inherit cmake

DESCRIPTION="C++11/14 constexpr based Containers, Algorithms, Random numbers and others"
HOMEPAGE="http://bolero-murakami.github.io/Sprout/"
SRC_URI="https://github.com/bolero-MURAKAMI/Sprout/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Sprout-${COMMIT}"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test texconv wavconv"
RESTRICT="!test? ( test )"

DEPEND="dev-libs/boost:="
RDEPEND="${DEPEND}"

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
