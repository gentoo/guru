# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A C++11 Interface for Rs C Interface'
KEYWORDS="~amd64"
LICENSE='MIT'

SUGGESTED_PACKAGES="
	dev-R/bench
	dev-R/brio
	dev-R/callr
	dev-R/cli
	dev-R/covr
	dev-R/decor
	dev-R/desc
	dev-R/ggplot2
	dev-R/glue
	dev-R/knitr
	dev-R/lobstr
	dev-R/mockery
	dev-R/progress
	dev-R/Rcpp
	dev-R/rmarkdown
	dev-R/scales
	dev-R/testthat
	dev-R/tibble
	dev-R/vctrs
	dev-R/withr
"
