# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Search and Query CRAN R Packages'
HOMEPAGE="
	https://github.com/r-hub/pkgsearch
	https://r-hub.github.io/pkgsearch/
	https://cran.r-project.org/package=pkgsearch
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/curl
	dev-R/jsonlite
	dev-R/prettyunits
	>=dev-R/parsedate-1.3.0
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/memoise
	dev-R/mockery
	dev-R/pillar
	>=dev-R/pingr-2.0.0
	dev-R/rstudioapi
	dev-R/shiny
	dev-R/shinyjs
	dev-R/shinyWidgets
	>=dev-R/testthat-2.1.0
	dev-R/whoami
"
