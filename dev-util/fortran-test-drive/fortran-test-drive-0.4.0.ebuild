# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FORTRAN_STANDARD="2003"

inherit cmake fortran-2

MY_PN="test-drive"
SRC_URI="https://github.com/fortran-lang/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="The simple testing framework (for Fortran)"
HOMEPAGE="https://github.com/fortran-lang/test-drive"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="mirror !test? ( test )"

S="${WORKDIR}/${MY_PN}-${PV}"


pkg_setup() {
	fortran-2_pkg_setup
}
