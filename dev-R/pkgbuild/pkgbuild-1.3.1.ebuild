# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Find Tools Needed to Build R Packages'
HOMEPAGE="
	https://github.com/r-lib/pkgbuild
	https://cran.r-project.org/package=pkgbuild
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/cli
	>=dev-R/callr-3.2.0
	dev-R/desc
	>=dev-R/withr-2.3.0
	dev-R/R6
	>=dev-lang/R-3.1
	dev-R/crayon
	dev-R/prettyunits
	dev-R/rprojroot
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/cpp11
	dev-R/Rcpp
	dev-R/testthat
"
