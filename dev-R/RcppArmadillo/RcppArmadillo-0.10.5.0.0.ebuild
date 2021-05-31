# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Rcpp Integration for the Armadillo templated linear algebra library'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.3.0
	>=dev-R/Rcpp-0.11.0
"
RDEPEND="
	${DEPEND}
	dev-R/Rcpp
"
