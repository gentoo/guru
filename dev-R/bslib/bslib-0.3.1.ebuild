# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages #edo

DESCRIPTION="Custom 'Bootstrap' 'Sass' Themes for 'shiny' and 'rmarkdown'"
KEYWORDS="~amd64"
LICENSE='MIT'
# Tests need shiny and rmarkdown (circ. dep, will enable once added)
#RESTRICT="!test? ( test )"
#IUSE="test"

DEPEND="
	>=dev-R/htmltools-0.5.2
	dev-R/jsonlite
	>=dev-R/sass-0.4.0
	>=dev-R/jquerylib-0.1.3
	dev-R/rlang"
#	test? (
#		dev-R/withr
#		dev-R/testthat
#		>=dev-R/shiny-1.6.0
#		>=dev-R/rmarkdown-2.7
#	)

SUGGESTED_PACKAGES="
	>=dev-R/shiny-1.6.0
	>=dev-R/rmarkdown-2.7
	dev-R/thematic
	dev-R/knitr
	dev-R/testthat
	dev-R/withr
	dev-R/rappdirs
	dev-R/curl
	dev-R/magrittr
"

#src_test() {
#	cd "${WORKDIR}/${P}/tests" || die
#	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla test-all.R
#}
