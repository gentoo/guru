# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Tools for Working with Categorical Variables (Factors)'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/ellipsis
	dev-R/magrittr
	dev-R/rlang
	dev-R/tibble
	test? (
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/dplyr
	dev-R/ggplot2
	dev-R/knitr
	dev-R/readr
	dev-R/rmarkdown
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
