# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Encapsulated Classes with Reference Semantics'
SRC_URI="http://cran.r-project.org/src/contrib/R6_2.4.1.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://r6.r-lib.org
	https://github.com/r-lib/R6
	https://cran.r-project.org/package=R6
"
IUSE="${IUSE-}"
DEPEND=">=dev-lang/R-3.0"
