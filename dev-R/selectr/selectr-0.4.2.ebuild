# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Translate CSS Selectors to XPath Expressions'
KEYWORDS="~amd64"
LICENSE='BSD'
RESTRICT="!test? ( test )"
IUSE="test"
CRAN_PV="$(ver_rs 2 -)"

DEPEND="
	dev-R/stringr
	dev-R/R6
	test? (
		dev-R/testthat
		dev-R/XML
		dev-R/xml2
	)
"

SUGGESTED_PACKAGES="
	dev-R/testthat
	dev-R/XML
	dev-R/xml2
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla test-all.R
}

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"
