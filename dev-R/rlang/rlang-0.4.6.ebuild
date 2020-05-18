# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Functions for Base Types and Core R and Tidyverse Features'
SRC_URI="http://cran.r-project.org/src/contrib/rlang_0.4.6.tar.gz"
LICENSE='GPL-3'
HOMEPAGE="
	https://rlang.r-lib.org
	https://github.com/r-lib/rlang
	https://cran.r-project.org/package=rlang
"
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND=">=dev-lang/R-3.2.0"
RDEPEND="${DEPEND}"
