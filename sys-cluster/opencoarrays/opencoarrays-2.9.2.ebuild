# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=emake
FORTRAN_STANDARD="2003"

inherit cmake fortran-2

MY_PN="OpenCoarrays"

DESCRIPTION="A parallel application binary interface for Fortran 2018 compilers"
HOMEPAGE="http://www.opencoarrays.org/"
SRC_URI="https://github.com/sourceryinstitute/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/mpi[fortran]
"
DEPEND="
	${RDEPEND}
"

pkg_setup() {
	fortran-2_pkg_setup
}

src_test() {
	cmake_build test
}
