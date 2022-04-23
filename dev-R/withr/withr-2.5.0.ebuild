# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Run Code With Temporarily Modified Global State'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND=">=dev-lang/R-3.2.0"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/callr
	dev-R/covr
	dev-R/DBI
	dev-R/knitr
	virtual/lattice
	dev-R/rlang
	>=dev-R/rmarkdown-2.12
	dev-R/RSQLite
	>=dev-R/testthat-3.0.0
"
