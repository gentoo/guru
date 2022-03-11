# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='In-Line Documentation for R'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	>=dev-lang/R-3.2
	dev-R/brew
	dev-R/commonmark
	dev-R/cpp11
	>=dev-R/desc-1.2.0
	dev-R/digest
	dev-R/knitr
	>=dev-R/pkgload-1.0.2
	>=dev-R/purrr-0.3.3
	>=dev-R/R6-2.1.2
	dev-R/rlang
	dev-R/stringi
	>=dev-R/stringr-1.0.0
	dev-R/xml2
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/devtools
	dev-R/rmarkdown
	>=dev-R/testthat-2.1.0
	dev-R/R-methodsS3
	dev-R/R-oo
"
