# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Cache R Objects with Automatic Pruning'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	dev-R/rlang
	dev-R/fastmap
	test? ( dev-R/testthat )
"

SUGGESTED_PACKAGES="
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
