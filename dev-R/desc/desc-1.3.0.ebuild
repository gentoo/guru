# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Manipulate DESCRIPTION Files'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.1.0
	dev-R/crayon
	dev-R/R6
	dev-R/rprojroot
"
RDEPEND="${DEPEND}"
