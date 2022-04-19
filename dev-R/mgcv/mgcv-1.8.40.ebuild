# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 -)"

inherit R-packages

DESCRIPTION='Mixed GAM Computation Vehicle with automatic smoothness estimation'
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.6.0
	!dev-lang/R[-minimal]
	virtual/nlme
	virtual/Matrix
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	virtual/survival
	virtual/MASS
"
