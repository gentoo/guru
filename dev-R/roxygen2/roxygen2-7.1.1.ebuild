# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='In-Line Documentation for R'
KEYWORDS="~amd64"
LICENSE='GPL-2+'

DEPEND="
	dev-R/brew
	dev-R/rlang
	dev-R/digest
	>=dev-R/desc-1.2.0
	dev-R/knitr
	dev-R/xml2
	>=dev-lang/R-3.2
	dev-R/commonmark
	>=dev-R/pkgload-1.0.2
	>=dev-R/purrr-0.3.3
	>=dev-R/R6-2.1.2
	>=dev-R/Rcpp-0.11.0
	dev-R/stringi
	>=dev-R/stringr-1.0.0
"
RDEPEND="
	${DEPEND}
	dev-R/Rcpp
"
