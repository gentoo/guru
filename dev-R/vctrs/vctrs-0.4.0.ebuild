# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Vector Helpers'
HOMEPAGE="
	https://github.com/r-lib/vctrs
	https://cran.r-project.org/package=vctrs
"
LICENSE='GPL-3'

KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.3
	>=dev-R/cli-3.2.0
	dev-R/glue
	>=dev-R/rlang-1.0.2
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bit64
	dev-R/covr
	dev-R/crayon
	>=dev-R/dplyr-0.8.5
	dev-R/generics
	dev-R/knitr
	>=dev-R/pillar-1.4.4
	>=dev-R/pkgdown-2.0.1
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.0
	>=dev-R/tibble-3.1.3
	dev-R/withr
	dev-R/xml2
	>=dev-R/waldo-0.2.0
	dev-R/zeallot
"
