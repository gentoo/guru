# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Easily Harvest (Scrape) Web Pages'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/httr-0.5
	>=dev-R/lifecycle-1.0.0
	dev-R/magrittr
	>=dev-R/rlang-0.4.10
	dev-R/selectr
	dev-R/tibble
	>=dev-R/xml2-1.3
	test? (
		>=dev-R/testthat-3.0.2
		dev-R/webfakes
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/glue
	dev-R/knitr
	dev-R/readr
	dev-R/rmarkdown
	dev-R/repurrrsive
	dev-R/spelling
	>=dev-R/stringi-0.3.1
	>=dev-R/testthat-3.0.2
	dev-R/webfakes
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	# These require network access
	rm testthat/test-session.R
	rm testthat/test-rename.R
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
