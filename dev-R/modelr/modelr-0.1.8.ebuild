# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Modelling Functions that Work with the Pipe'
KEYWORDS="~amd64"
LICENSE='GPL-3'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/broom
	dev-R/magrittr
	>=dev-R/purrr-0.2.2
	>=dev-R/rlang-0.2.0
	dev-R/tibble
	>=dev-R/tidyr-0.8.0
	dev-R/tidyselect
	dev-R/vctrs
	test? (
		dev-R/testthat
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/ggplot2
	dev-R/testthat
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
