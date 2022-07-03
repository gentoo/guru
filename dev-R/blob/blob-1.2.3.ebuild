# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="A Simple S3 Class for Representing Vectors of Binary Data ('BLOBS')"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"
DEPEND="
	dev-R/rlang
	>=dev-R/vctrs-0.2.1
	test? ( dev-R/testthat )
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/crayon
	>=dev-R/pillar-1.2.1
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
