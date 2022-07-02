# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Read and Write from the System Clipboard'
KEYWORDS="~amd64"
LICENSE='GPL-3'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	|| ( x11-misc/xclip x11-misc/xsel gui-apps/wl-clipboard )
	test? (
		>=dev-R/testthat-2.0.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/knitr
	dev-R/rmarkdown
	>=dev-R/rstudioapi-0.5
	>=dev-R/testthat-2.0.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
