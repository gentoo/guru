# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Functional Programming Tools'
LICENSE='GPL-3'
HOMEPAGE="
	https://purrr.tidyverse.org
	https://github.com/tidyverse/purrr
	https://cran.r-project.org/package=purrr
"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/magrittr-1.5
	>=dev-R/rlang-0.3.1
"
RDEPEND="${DEPEND}"
