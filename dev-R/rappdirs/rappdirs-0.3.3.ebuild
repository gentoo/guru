# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Application Directories: Determine Where to Save Data, Caches, and Logs'
HOMEPAGE="
	https://cran.r-project.org/package=rappdirs
	https://rappdirs.r-lib.org
	https://github.com/r-lib/rappdirs
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-lang/R-3.2"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/roxygen2
	>=dev-R/testthat-3.0.0
	dev-R/withr
"
