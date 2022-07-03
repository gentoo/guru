# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='R Database Interface'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/assertthat-0.2.0
	>=dev-R/blob-1.2.0
	>=dev-R/cli-3.3.0
	>=dev-R/DBI-1.0.0
	>=dev-R/dplyr-1.0.9
	>=dev-R/glue-1.2.0
	>=dev-R/lifecycle-1.0.0
	dev-R/magrittr
	>=dev-R/pillar-1.5.0
	>=dev-R/purrr-0.2.5
	>=dev-R/R6-2.2.2
	>=dev-R/rlang-1.0.0
	>=dev-R/tibble-1.4.2
	>=dev-R/tidyselect-0.2.4
	>=dev-R/vctrs-0.4.1
	dev-R/withr
	test? (
		dev-R/bit64
		>=dev-R/RSQLite-2.1.0
		>=dev-R/testthat-3.0.2
		>=dev-R/tidyr-1.2.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/bit64
	dev-R/covr
	dev-R/knitr
	dev-R/Lahman
	dev-R/nycflights13
	dev-R/odbc
	>=dev-R/RMariaDB-1.0.2
	dev-R/rmarkdown
	>=dev-R/RPostgres-1.1.3
	dev-R/RPostgreSQL
	>=dev-R/RSQLite-2.1.0
	>=dev-R/testthat-3.0.2
	>=dev-R/tidyr-1.2.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
