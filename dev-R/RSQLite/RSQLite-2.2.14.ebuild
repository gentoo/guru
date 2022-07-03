# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='SQLite Interface for R'
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	dev-R/bit64
	>=dev-R/blob-1.2.0
	>=dev-R/DBI-1.1.0
	dev-R/memoise
	dev-R/pkgconfig
	dev-R/Rcpp
	>=dev-R/plogr-0.2.0
	test? (
		dev-R/callr
		>=dev-R/DBItest-1.7.0
		dev-R/hms
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/callr
	>=dev-R/DBItest-1.7.0
	dev-R/gert
	dev-R/gh
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/hms
	dev-R/rvest
	dev-R/testthat
	dev-R/xml2
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
