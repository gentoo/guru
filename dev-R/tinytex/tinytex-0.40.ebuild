# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Helper Functions to Install and Maintain TeX Live, and Compile LaTeX Documents'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/xfun
	test? (
		dev-R/testit
	)
"

SUGGESTED_PACKAGES="
	dev-R/testit
	dev-R/rstudioapi
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla test-cran.R
}
