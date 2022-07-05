# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='R Interface to NLopt'
KEYWORDS="~amd64"
LICENSE='LGPL-3+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/testthat-3.0.0
	test? (
		dev-R/xml2
	)
	>=sci-libs/nlopt-2.7.0
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/knitr
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.0
	dev-R/xml2
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
