# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Unit Testing for R'
HOMEPAGE="
	https://testthat.r-lib.org/
	https://github.com/r-lib/testthat
	https://cran.r-project.org/package=testthat
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.1
	dev-R/brio
	>=dev-R/callr-3.5.1
	>=dev-R/cli-2.2.0
	>=dev-R/crayon-1.3.4
	dev-R/desc
	dev-R/digest
	>=dev-R/ellipsis-0.2.0
	dev-R/evaluate
	dev-R/jsonlite
	dev-R/lifecycle
	dev-R/magrittr
	dev-R/pkgload
	dev-R/praise
	dev-R/processx
	>=dev-R/ps-1.3.4
	>=dev-R/R6-2.2.0
	>=dev-R/rlang-0.4.9
	>=dev-R/waldo-0.2.4
	>=dev-R/withr-2.4.3
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	>=dev-R/curl-0.9.5
	>=dev-R/diffviewer-0.1.0
	dev-R/knitr
	dev-R/mockery
	dev-R/rmarkdown
	dev-R/rstudioapi
	dev-R/shiny
	dev-R/usethis
	>=dev-R/vctrs-0.1.0
	dev-R/xml2
"
