# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Finding Files in Project Subdirectories'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-lang/R-3.0.0"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/knitr
	dev-R/lifecycle
	dev-R/mockr
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.0
	dev-R/withr
"
