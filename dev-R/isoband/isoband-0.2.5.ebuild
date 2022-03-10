# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Generate Isolines and Isobands from regularky spaced elevation grids'
KEYWORDS="~amd64"
LICENSE='MIT'

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/ggplot2
	dev-R/knitr
	dev-R/magick
	dev-R/microbenchmark
	dev-R/rmarkdown
	dev-R/sf
	dev-R/testthat
	dev-R/xml2
"
