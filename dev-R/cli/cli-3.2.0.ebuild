# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Helpers for Developing Command Line Interfaces'
HOMEPAGE="
	https://github.com/r-lib/cli
	https://cran.r-project.org/package=cli
"
LICENSE='MIT'
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-2.1.0
	dev-R/glue
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/asciicast
	dev-R/callr
	dev-R/covr
	dev-R/digest
	dev-R/htmltools
	dev-R/htmlwidgets
	dev-R/knitr
	dev-R/mockery
	dev-R/processx
	>=dev-R/ps-1.3.4.90000
	dev-R/rlang
	dev-R/rmarkdown
	dev-R/rstudioapi
	dev-R/shiny
	dev-R/testthat
	dev-R/tibble
	dev-R/whoami
	dev-R/withr
"
