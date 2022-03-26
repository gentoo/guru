# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 -)"

inherit R-packages

DESCRIPTION='Linear and Nonlinear Mixed Effects Models'
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.5.0
	!dev-lang/R[-minimal]
	virtual/lattice
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/Hmisc
	dev-R/MASS
	dev-R/SASmixed
"
