# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Make Dealing with Dates a Little Easier'
KEYWORDS="~amd64"
LICENSE='GPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	dev-R/generics
	>=dev-R/cpp11-0.2.7
	sys-libs/timezone-data
	test? (
		>=dev-R/testthat-2.1.0
		>=dev-R/vctrs-0.3.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/knitr
	>=dev-R/testthat-2.1.0
	>=dev-R/vctrs-0.3.0
	dev-R/rmarkdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
