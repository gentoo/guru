# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Functional Programming Tools'
SRC_URI="http://cran.r-project.org/src/contrib/purrr_0.3.4.tar.gz"
LICENSE='GPL-3'
HOMEPAGE="
	http://purrr.tidyverse.org
	https://github.com/tidyverse/purrr
	https://cran.r-project.org/package=purrr
"
IUSE="${IUSE-}"
DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/magrittr-1.5
	>=dev-R/rlang-0.3.1
"
