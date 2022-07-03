# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Pretty Time of Day'
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	>=dev-R/ellipsis-0.3.2
	dev-R/lifecycle
	dev-R/pkgconfig
	dev-R/rlang
	>=dev-R/vctrs-0.3.8
	test? (
		>=dev-R/testthat-3.0.0
		>=dev-R/pillar-1.1.0
		dev-R/lubridate
	)
"

SUGGESTED_PACKAGES="
	dev-R/crayon
	dev-R/lubridate
	>=dev-R/pillar-1.1.0
	>=dev-R/testthat-3.0.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
