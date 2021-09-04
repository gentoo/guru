# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 -)"

inherit R-packages

DESCRIPTION='Sparse and Dense Matrix Classes and Methods'
KEYWORDS="~amd64"
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.5.0[minimal]
	virtual/lattice
"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export AR
	R-packages_src_prepare
}
