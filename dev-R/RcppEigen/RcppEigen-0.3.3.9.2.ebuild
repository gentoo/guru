# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="'Rcpp' Integration for the 'Eigen' Templated Linear Algebra Library"
KEYWORDS="~amd64"
LICENSE='GPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	|| ( dev-R/Matrix dev-lang/R[-minimal] )
	dev-R/Rcpp
	test? (
		dev-R/tinytest
	)
"

SUGGESTED_PACKAGES="
	dev-R/inline
	dev-R/tinytest
	dev-R/pkgKitten
	dev-R/microbenchmark
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla tinytest.R
}
