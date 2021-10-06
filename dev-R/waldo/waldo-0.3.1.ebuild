# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Find Differences Between R Objects'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/cli
	>=dev-R/diffobj-0.3.4
	dev-R/fansi
	dev-R/glue
	dev-R/rematch2
	>=dev-R/rlang-0.4.10
	dev-R/tibble
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	>=dev-R/testthat-3.0.0
	dev-R/R6
	dev-R/withr
	dev-R/xml2
"
