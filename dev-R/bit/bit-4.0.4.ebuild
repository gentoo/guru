# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Classes and Methods for Fast Memory-Efficient Boolean Selections'
KEYWORDS="~amd64"
LICENSE='GPL-2 GPL-3'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	test? ( >=dev-R/testthat-0.11.0 )
"

SUGGESTED_PACKAGES="
	>=dev-R/testthat-0.11.0
	dev-R/roxygen2
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/microbenchmark
	>=dev-R/bit64-4.0.0
	>=dev-R/ff-4.0.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
