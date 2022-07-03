# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Functions to Inline C, C++, Fortran Function Calls from R'
KEYWORDS="~amd64"
LICENSE='LGPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	test? (
		>=dev-R/Rcpp-0.11.0
		dev-R/tinytest
	)
"

SUGGESTED_PACKAGES="
	>=dev-R/Rcpp-0.11.0
	dev-R/tinytest
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla tinytest.R
}
