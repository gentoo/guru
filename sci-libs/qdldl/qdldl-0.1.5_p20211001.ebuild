# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="9fae555ca11046362be143a24cca66c311eeb884"

inherit cmake

DESCRIPTION="A free LDL factorisation routine"
HOMEPAGE="https://github.com/osqp/qdldl"
SRC_URI="https://github.com/osqp/${PN}/archive/${COMMIT}.tar.gz -> ${PF}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="coverage single-precision test"

RESTRICT="!test? ( test )"

src_configure() {
	mycmakeargs=(
		-DCOVERAGE=$(usex coverage)
		-DDFLOAT=$(usex single-precision)
		-DQDLDL_BUILD_STATIC_LIB=$(usex test)
		-DQDLDL_UNITTESTS=$(usex test)

		-DQDLDL_BUILD_DEMO_EXE=OFF
		-DQDLDL_BUILD_SHARED_LIB=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	dodoc README.md CHANGELOG.md
}
