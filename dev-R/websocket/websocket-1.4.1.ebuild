# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="'WebSocket' Client Library"
KEYWORDS="~amd64"
LICENSE='GPL-2'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/R6
	dev-R/later
	dev-R/cpp11
	dev-R/AsioHeaders
	test? (
		dev-R/testthat
		dev-R/httpuv
	)
"

SUGGESTED_PACKAGES="
	dev-R/httpuv
	dev-R/testthat
	dev-R/knitr
	dev-R/rmarkdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
