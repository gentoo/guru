# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 -)"

inherit R-packages

DESCRIPTION="Support Functions and Datasets for variables and Ripley's MASS"
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='|| ( GPL-2 GPL-3 )'

DEPEND="
	>=dev-lang/R-3.3.0
	!dev-lang/R[-minimal]
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/lattice
	dev-R/nlme
	dev-R/nnet
	dev-R/survival
"
