# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Select from a Set of Strings'
LICENSE='GPL-3'
HOMEPAGE="
	https://tidyselect.r-lib.org
	https://github.com/r-lib/tidyselect
	https://cran.r-project.org/package=tidyselect
"
KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.2
	dev-R/ellipsis
	>=dev-R/glue-1.3.0
	>=dev-R/purrr-0.3.2
	>=dev-R/rlang-1.0.1
	>=dev-R/vctrs-0.3.0
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/crayon
	dev-R/dplyr
	dev-R/knitr
	dev-R/magrittr
	dev-R/rmarkdown
	>=dev-R/testthat-3.1.1
	>=dev-R/tibble-2.1
	dev-R/withr
"
