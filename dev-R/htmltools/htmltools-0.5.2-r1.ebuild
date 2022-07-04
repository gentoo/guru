# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Tools for HTML'
KEYWORDS="~amd64"
LICENSE='GPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/digest
	dev-R/base64enc
	>=dev-R/rlang-0.4.10
	dev-R/fastmap
	test? (
		dev-R/markdown
		dev-R/withr
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/markdown
	dev-R/testthat
	dev-R/withr
	dev-R/Cairo
	dev-R/ragg
	dev-R/shiny
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	rm "testthat/test-images.R" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla test-all.R
}
