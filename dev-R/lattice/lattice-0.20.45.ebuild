# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 '-')"

inherit R-packages

DESCRIPTION='Trellis Graphics for R'
HOMEPAGE="
	https://lattice.r-forge.r-project.org/index.php
	https://CRAN.R-project.org/package=lattice
"
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.0.0
	!dev-lang/R[-minimal]
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	virtual/KernSmooth
	virtual/MASS
	dev-R/latticeExtra
"
