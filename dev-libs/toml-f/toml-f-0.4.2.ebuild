# Copyright 1999-2024 Gentoo Authors
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

	if ! use test ; then
		sed -i -e '/^enable_testing()/d' \
		-e '/^add_subdirectory("test")/d' CMakeLists.txt || die
	fi

	cmake_src_prepare
}
