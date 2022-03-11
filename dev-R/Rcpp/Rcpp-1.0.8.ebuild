# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Seamless R and C++ Integration'
LICENSE='GPL-2+'
HOMEPAGE="
	http://www.rcpp.org
	http://dirk.eddelbuettel.com/code/rcpp.html
	https://github.com/RcppCore/Rcpp
	https://cran.r-project.org/package=Rcpp
"
KEYWORDS="~amd64"

SUGGESTED_PACKAGES="
	dev-R/tinytest
	dev-R/inline
	dev-R/rbenchmark
	>=dev-R/pkgKitten-0.1.2
"
