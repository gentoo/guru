# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_cut 2-4 ${PV})"

inherit R-packages

DESCRIPTION='Header-Only C++ Mathematical Optimization library for armadillo'
SRC_URI="mirror://cran/src/contrib/Archive/RcppEnsmallen/RcppEnsmallen_${PV}.tar.gz"
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.3.0
	dev-R/Rcpp
	=sci-libs/ensmallen-${MYPV}*
"
RDEPEND="
	${DEPEND}
	dev-R/Rcpp
	>=dev-R/RcppArmadillo-0.8.400.0.0
"
