# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Simulate Package Installation and Attach'
HOMEPAGE="
	https://cran.r-project.org/package=pkgload
	https://github.com/r-lib/pkgload
	https://pkgload.r-lib.org/
"

KEYWORDS="~amd64"
LICENSE='GPL-3'

DEPEND="
	>=dev-R/cli-3.3.0
	dev-R/desc
	dev-R/crayon
	dev-R/fs
	dev-R/glue
	dev-R/rprojroot
	>=dev-R/rlang-1.0.3
	dev-R/rstudioapi
	>=dev-R/withr-2.4.3
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bitops
	dev-R/mathjaxr
	dev-R/pak
	dev-R/covr
	dev-R/pkgbuild
	dev-R/Rcpp
	>=dev-R/testthat-3.1.0
	dev-R/remotes
	dev-R/rstudioapi
"
