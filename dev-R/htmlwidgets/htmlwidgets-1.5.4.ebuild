# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="HTML Widgets for R"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/htmltools-0.3
	>=dev-R/jsonlite-0.9.16
	dev-R/yaml
	test? (
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	>=dev-R/knitr-1.8
	dev-R/rmarkdown
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
