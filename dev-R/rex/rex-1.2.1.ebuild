# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Friendly Regular Expressions'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="dev-R/lazyeval"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/dplyr
	dev-R/ggplot2
	dev-R/Hmisc
	dev-R/knitr
	dev-R/magrittr
	dev-R/rmarkdown
	dev-R/roxygen2
	dev-R/rvest
	dev-R/stringr
	dev-R/testthat
"
