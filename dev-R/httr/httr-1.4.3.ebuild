# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Tools for Working with URLs and HTTP'
HOMEPAGE="
	https://github.com/r-lib/httr
	https://httr.r-lib.org/
	https://cran.r-project.org/package=httr
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/curl-3.0.0
	>=dev-R/openssl-0.8
	dev-R/mime
	dev-R/jsonlite
	dev-R/R6
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/httpuv
	dev-R/jpeg
	dev-R/knitr
	dev-R/png
	dev-R/readr
	dev-R/rmarkdown
	>=dev-R/testthat-0.8.0
	dev-R/xml2
"
