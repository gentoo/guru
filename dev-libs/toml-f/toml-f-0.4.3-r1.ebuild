# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit cmake fortran-2

DESCRIPTION="TOML parser implementation for data serialization and deserialization in Fortran"
HOMEPAGE="https://toml-f.readthedocs.io"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0/4"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="
	test? ( dev-util/fortran-test-drive )
"

src_prepare() {
	default

	sed -i -e '/^cmake_minimum_required/s/VERSION 3.9/VERSION 3.10/' \
		 CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test ON OFF)
	)
	cmake_src_configure
}
