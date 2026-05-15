# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit cmake fortran-2

MY_PN="test-drive"

DESCRIPTION="The simple testing framework (for Fortran)"
HOMEPAGE="https://github.com/fortran-lang/test-drive"
SRC_URI="https://github.com/fortran-lang/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="test"
RESTRICT="mirror !test? ( test )"

pkg_setup() {
	fortran-2_pkg_setup
}

src_prepare() {
	default

	sed -i -e '/^cmake_minimum_required/s/VERSION 3.9/VERSION 3.10/' \
		 CMakeLists.txt || die

	cmake_src_prepare
}
