# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Seamless R and C++ Integration'
HOMEPAGE="
	https://www.rcpp.org
	http://dirk.eddelbuettel.com/code/rcpp.html
	https://github.com/RcppCore/Rcpp
	https://cran.r-project.org/package=Rcpp
"

LICENSE='GPL-2+ Boost-1.0'
KEYWORDS="~amd64"
IUSE="examples"

src_prepare() {
	if ! use examples ; then
		rm -r inst/examples || die
	fi
	rm -r inst/tinytest || die
	R-packages_src_prepare
}

SUGGESTED_PACKAGES="
	dev-R/tinytest
	dev-R/inline
	dev-R/rbenchmark
	>=dev-R/pkgKitten-0.1.2
"
