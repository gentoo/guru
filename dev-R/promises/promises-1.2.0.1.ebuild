# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Abstractions for Promise-Based Asynchronous Programming'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/R6
	dev-R/Rcpp
	dev-R/later
	dev-R/rlang
	dev-R/magrittr
	test? (
		dev-R/testthat
		>=dev-R/future-1.21.0
		>=dev-R/fastmap-1.1.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	>=dev-R/future-1.21.0
	>=dev-R/fastmap-1.1.0
	dev-R/purrr
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/vembedr
	dev-R/spelling
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
