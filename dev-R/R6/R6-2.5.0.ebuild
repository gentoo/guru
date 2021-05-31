# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Encapsulated Classes with Reference Semantics'
LICENSE='MIT'
HOMEPAGE="
	https://r6.r-lib.org
	https://github.com/r-lib/R6
	https://cran.r-project.org/package=R6
"
KEYWORDS="~amd64"
DEPEND=">=dev-lang/R-3.0"
RDEPEND="${DEPEND}"
