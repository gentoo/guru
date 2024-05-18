# Copyright 2023 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Modular web engine (HTML/CSS parser, renderer, ...)"
HOMEPAGE="https://lexbor.com/ https://github.com/lexbor/lexbor"
SRC_URI="https://github.com/lexbor/lexbor/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples static-libs test"

RESTRICT="!test? ( test )"

src_prepare() {
	default
	cmake_src_prepare

	sed -i 's;${LEXBOR_OPTIMIZATION_LEVEL};;' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DLEXBOR_BUILD_EXAMPLES=$(usex examples)
		-DLEXBOR_BUILD_UTILS=$(usex examples)
		-DLEXBOR_BUILD_STATIC=$(usex static-libs)
		-DLEXBOR_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
