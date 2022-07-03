# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Parallel Programming Tools for 'Rcpp'"
KEYWORDS="~amd64"
LICENSE='GPL-3+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	test? (
		dev-R/RUnit
		dev-R/Rcpp
	)
	dev-cpp/tbb
"

SUGGESTED_PACKAGES="
	dev-R/RUnit
	dev-R/Rcpp
	dev-R/knitr
	dev-R/rmarkdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla doRUnit.R
}
