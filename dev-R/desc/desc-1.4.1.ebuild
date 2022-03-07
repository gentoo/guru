# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Manipulate DESCRIPTION Files'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.4
	dev-R/cli
	dev-R/R6
	dev-R/rprojroot
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/callr
	dev-R/covr
	dev-R/gh
	dev-R/spelling
	dev-R/testthat
	dev-R/whoami
	dev-R/withr
"
