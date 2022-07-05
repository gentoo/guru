# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='C++ Header Files for Stan'
KEYWORDS="~amd64"
LICENSE='BSD'
CRAN_PV="$(ver_rs 3 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"

DEPEND="
	>=dev-R/RcppParallel-5.0.1
	dev-R/RcppEigen
"

SUGGESTED_PACKAGES="
	dev-R/Rcpp
	dev-R/BH
	>=dev-R/knitr-1.15.1
	dev-R/rmarkdown
	dev-R/Matrix
	dev-R/rstan
"
