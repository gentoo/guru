# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='HTTP and WebSocket Server Library'
KEYWORDS="~amd64"
LICENSE='GPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/Rcpp-1.0.7
	dev-R/R6
	dev-R/promises
	>=dev-R/later-0.8.0
	sys-libs/zlib
	test? (
		dev-R/testthat
		dev-R/callr
		dev-R/curl
		dev-R/websocket
	)
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	dev-R/callr
	dev-R/curl
	dev-R/websocket
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
