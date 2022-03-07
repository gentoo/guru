# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Interpreted String Literals'
HOMEPAGE="
	https://glue.tidyverse.org
	https://github.com/tidyverse/glue
	https://cran.r-project.org/package=glue
"
LICENSE='MIT'
KEYWORDS="~amd64"
DEPEND=">=dev-lang/R-3.4"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/crayon
	dev-R/DBI
	dev-R/dplyr
	dev-R/forcats
	dev-R/ggplot2
	dev-R/knitr
	dev-R/magrittr
	dev-R/microbenchmark
	dev-R/R-utils
	dev-R/rmarkdown
	dev-R/rprintf
	dev-R/RSQLite
	dev-R/stringr
	>=dev-R/testthat-3.0.0
	>=dev-R/vctrs-0.3.0
	>=dev-R/waldo-0.3.0
	dev-R/withr
"
