# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Syntactically Awesome Style Sheets ('Sass')"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/fs
	>=dev-R/rlang-0.4.10
	>=dev-R/htmltools-0.5.1
	dev-R/R6
	dev-R/rappdirs
	test? (
		dev-R/withr
		dev-R/testthat
		dev-R/shiny
	)
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/withr
	dev-R/shiny
	dev-R/curl
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
