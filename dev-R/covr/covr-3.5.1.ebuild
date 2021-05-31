# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Test Coverage for Packages'
KEYWORDS="~amd64"
LICENSE='GPL-3'

DEPEND="
	dev-R/jsonlite
	>=dev-R/withr-1.0.2
	dev-R/crayon
	dev-R/rex
	>=dev-lang/R-3.1.0
	dev-R/digest
	dev-R/httr
	dev-R/yaml
"
RDEPEND="${DEPEND}"
