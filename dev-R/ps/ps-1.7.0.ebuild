# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='List, Query, Manipulate System Processes'
HOMEPAGE="
	https://cran.r-project.org/package=ps
	https://github.com/r-lib/ps
	https://ps.r-lib.org/
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-lang/R-3.1"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-fPIE.patch" )

SUGGESTED_PACKAGES="
	dev-R/callr
	dev-R/covr
	dev-R/pingr
	>=dev-R/processx-3.1.0
	dev-R/R6
	dev-R/rlang
	>=dev-R/testthat-3.0.0
	dev-R/tibble
"
