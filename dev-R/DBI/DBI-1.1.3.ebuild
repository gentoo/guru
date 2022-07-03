# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='R Database Interface'
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	test? (
		>=dev-R/RSQLite-1.1.2
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/blob
	dev-R/covr
	dev-R/DBItest
	dev-R/dbplyr
	dev-R/downlit
	dev-R/dplyr
	dev-R/glue
	dev-R/hms
	dev-R/knitr
	dev-R/magrittr
	dev-R/RMariaDB
	dev-R/rmarkdown
	dev-R/rprojroot
	>=dev-R/RSQLite-1.1.2
	dev-R/testthat
	dev-R/xml2
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
