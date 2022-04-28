# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature

DESCRIPTION="A solver for package problems in CUDF format"
HOMEPAGE="
	https://github.com/potassco/aspcud
	https://potassco.org/aspcud/
"
SRC_URI="https://github.com/potassco/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-libs/boost:="
DEPEND="${RDEPEND}"
BDEPEND="dev-util/re2c"

RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DASPCUD_BUILD_TESTS=$(usex test)

		-DASPCUD_BUILD_STATIC=OFF
	)
	cmake_src_configure
}

pkg_postinst() {
	optfeature "dependencies needed at runtime" sci-mathematics/clasp sci-mathematics/clingo
}
