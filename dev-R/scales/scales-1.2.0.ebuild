# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Scale Functions for Visualization'
HOMEPAGE="
	https://scales.r-lib.org/
	https://github.com/r-lib/scales
	https://cran.r-project.org/package=scales
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.2
	dev-R/labeling
	dev-R/RColorBrewer
	>=dev-R/farver-2.0.3
	>=dev-R/munsell-0.5
	dev-R/lifecycle
	dev-R/R6
	>=dev-R/rlang-1.0.0
	dev-R/viridisLite
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bit64
	dev-R/covr
	dev-R/dichromat
	dev-R/ggplot2
	>=dev-R/hms-0.5.0
	dev-R/stringi
	>=dev-R/testthat-3.0.0
	>=dev-R/waldo-0.4.0
"
