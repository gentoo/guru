# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Tools for Working with ...'
HOMEPAGE="
	https://ellipsis.r-lib.org
	https://github.com/r-lib/ellipsis
	https://cran.r-project.org/package=ellipsis
"
LICENSE='GPL-3'
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/rlang-0.3.0
"
RDEPEND="${DEPEND}"
