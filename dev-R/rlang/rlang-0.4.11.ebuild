# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Functions for Base Types and Core R and Tidyverse Features'
LICENSE='GPL-3'
HOMEPAGE="
	https://rlang.r-lib.org
	https://github.com/r-lib/rlang
	https://cran.r-project.org/package=rlang
"
KEYWORDS="~amd64"
DEPEND=">=dev-lang/R-3.3.0"
RDEPEND="${DEPEND}"
