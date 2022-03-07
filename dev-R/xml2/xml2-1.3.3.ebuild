# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Work with XML files using a simple, consistent interface'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND=">=dev-lang/R-3.1.0"
RDEPEND="
	${DEPEND}
	dev-libs/libxml2
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/curl
	dev-R/httr
	dev-R/knitr
	dev-R/magrittr
	dev-R/mockery
	dev-R/markdown
	>=dev-R/testthat-2.1.0
"
