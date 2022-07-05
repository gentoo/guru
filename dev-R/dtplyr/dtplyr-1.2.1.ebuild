# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Data Table Back-End for 'dplyr'"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/crayon
	>=dev-R/data_table-1.13.0
	>=dev-R/dplyr-1.0.3
	dev-R/ellipsis
	dev-R/glue
	dev-R/lifecycle
	dev-R/rlang
	dev-R/tibble
	dev-R/tidyselect
	dev-R/vctrs
	test? (
		>=dev-R/testthat-3.0.0
		>=dev-R/tidyr-1.1.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/bench
	dev-R/covr
	dev-R/knitr
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.0
	>=dev-R/tidyr-1.1.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
