# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Simple, Consistent Wrappers for common string operations'
KEYWORDS="~amd64"
LICENSE='GPL-2'

DEPEND="
	>=dev-lang/R-3.1
	dev-R/magrittr
	>=dev-R/glue-1.2.0
	>=dev-R/stringi-1.1.7
"
RDEPEND="${DEPEND}"
