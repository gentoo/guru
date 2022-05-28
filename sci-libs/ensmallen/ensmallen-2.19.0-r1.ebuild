# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="header only C++ library for numerical optimization"
HOMEPAGE="
	https://ensmallen.org
	https://github.com/mlpack/ensmallen
"
SRC_URI="https://github.com/mlpack/ensmallen/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0/${PV}"
IUSE="openmp test"
RESTRICT="!test? ( test )"

RDEPEND="sci-libs/armadillo[lapack]"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/catch:0 )
"

src_prepare() {
	rm tests/catch.hpp || die
	use test && append-cxxflags "-I/usr/include/catch2"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_OPENMP=$(usex openmp)
	)
	cmake_src_configure
}

src_compile() {
	use test && cmake_src_compile ensmallen_tests
	return
}
