# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Manage the Life Cycle of your Package Functions'
HOMEPAGE="
	https://lifecycle.r-lib.org
	https://github.com/r-lib/lifecycle
	https://cran.r-project.org/package=lifecycle
"
LICENSE='GPL-3'
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.3
	dev-R/glue
	>=dev-R/rlang-0.4.10
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/crayon
	dev-R/lintr
	dev-R/tidyverse
	dev-R/knitr
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.1
	dev-R/tibble
	dev-R/vctrs
"
