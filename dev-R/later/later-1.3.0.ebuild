# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Utilities for Scheduling Functions to Execute Later with Event Loops'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/Rcpp-0.12.9
	dev-R/rlang
	test? (
		>=dev-R/testthat-2.1.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/knitr
	dev-R/rmarkdown
	>=dev-R/testthat-2.1.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
