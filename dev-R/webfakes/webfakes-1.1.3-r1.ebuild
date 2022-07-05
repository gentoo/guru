# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Fake Web Apps for HTTP Testing'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	test? (
		dev-R/callr
		dev-R/curl
		dev-R/glue
		dev-R/jsonlite
		dev-R/httr
		dev-R/httpuv
		>=dev-R/testthat-3.0.0
		dev-R/withr
	)
"

SUGGESTED_PACKAGES="
	dev-R/callr
	dev-R/curl
	dev-R/glue
	dev-R/jsonlite
	dev-R/httr
	dev-R/httpuv
	>=dev-R/testthat-3.0.0
	dev-R/withr
	dev-R/xml2
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
