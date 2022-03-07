# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='A Modern and Flexible Web Client for R'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-lang/R-3.0.0"
RDEPEND="
	${DEPEND}
	net-misc/curl
"

SUGGESTED_PACKAGES="
	dev-R/spelling
	>=dev-R/testthat-1.0.0
	dev-R/knitr
	dev-R/jsonlite
	dev-R/rmarkdown
	dev-R/magrittr
	>=dev-R/httpuv-1.4.4
	dev-R/webutils
"
