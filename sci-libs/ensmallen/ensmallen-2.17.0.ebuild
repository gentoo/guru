# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="header only C++ library for numerical optimization"
HOMEPAGE="https://ensmallen.org"
SRC_URI="https://github.com/mlpack/ensmallen/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"

LICENSE="BSD"
SLOT="0"
IUSE="openmp test"
RESTRICT="!test? ( test )"

RDEPEND="sci-libs/armadillo[lapack]"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DUSE_OPENMP=$(usex openmp)
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}
