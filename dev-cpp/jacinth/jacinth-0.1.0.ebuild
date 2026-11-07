# Copyright 2018-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="JSON for Postmodern C++"
HOMEPAGE="https://github.com/crueter/jacinth"
SRC_URI="https://github.com/crueter/jacinth/archive/${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-libs/yyjson-0.13.0
"
DEPEND="
	${RDEPEND}
	>=dev-libs/boost-1.87.0
"

src_configure() {
	local mycmakeargs=(
		-DJACINTH_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
