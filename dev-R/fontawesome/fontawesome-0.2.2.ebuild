# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Easily Work with 'Font Awesome' Icons"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/rlang-0.4.10
	>=dev-R/htmltools-0.5.1.1
	test? (
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/knitr
	dev-R/testthat
	dev-R/rsvg
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
