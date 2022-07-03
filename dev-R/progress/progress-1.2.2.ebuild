# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Terminal Progress Bars'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/hms
	dev-R/prettyunits
	dev-R/R6
	dev-R/crayon
	test? (
		dev-R/testthat
		dev-R/Rcpp
		dev-R/withr
	)
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	dev-R/Rcpp
	dev-R/withr
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
