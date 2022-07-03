# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages #edo

DESCRIPTION="Web Application Framework for R"
KEYWORDS="~amd64"
LICENSE='GPL-3'
# Tests need circular dependencies will enable once added
#RESTRICT="!test? ( test )"
#IUSE="test"

DEPEND="
	>=dev-R/httpuv-1.5.2
	>=dev-R/mime-0.3
	>=dev-R/jsonlite-0.9.16
	dev-R/xtable
	>=dev-R/fontawesome-0.2.1
	>=dev-R/htmltools-0.5.2
	>=dev-R/R6-2.0
	dev-R/sourcetools
	>=dev-R/later-1.0.0
	>=dev-R/promises-1.1.0
	dev-R/crayon
	>=dev-R/rlang-0.4.10
	dev-R/withr
	>=dev-R/commonmark-1.7
	>=dev-R/glue-1.3.2
	>=dev-R/bslib-0.3.0
	dev-R/cachem
	dev-R/ellipsis
	>=dev-R/lifecycle-0.2.0
"
#	test? (
#		>=dev-R/testthat-3.0.0
#		dev-R/markdown
#		dev-R/ggplot2
#		>=dev-R/reactlog-1.0.0
#		>=dev-R/shinytest-1.4.0.9003
#		dev-R/future
#		dev-R/dygraphs
#	)

SUGGESTED_PACKAGES="
	>=dev-R/Cairo-1.5.5
	>=dev-R/testthat-3.0.0
	>=dev-R/knitr-1.6
	dev-R/markdown
	dev-R/rmarkdown
	dev-R/ggplot2
	>=dev-R/reactlog-1.0.0
	dev-R/magrittr
	>=dev-R/shinytest-1.4.0.9003
	dev-R/yaml
	dev-R/future
	dev-R/dygraphs
	dev-R/ragg
	dev-R/showtext
	dev-R/sass
"

#src_test() {
#	cd "${WORKDIR}/${P}/tests" || die
#	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla test-all.R
#}
