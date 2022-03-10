# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A Simple and Robust JSON Parser and generator for R'
KEYWORDS="~amd64"
LICENSE='MIT'

#unbundling status: https://github.com/jeroen/jsonlite/issues/201

SUGGESTED_PACKAGES="
	dev-R/httr
	dev-R/curl
	dev-R/vctrs
	dev-R/testthat
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/R-rsp
	dev-R/sf
"
