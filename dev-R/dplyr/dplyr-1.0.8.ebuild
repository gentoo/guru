# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='A Grammar of Data Manipulation'
LICENSE='MIT'
HOMEPAGE="
	https://dplyr.tidyverse.org
	https://github.com/tidyverse/dplyr
	https://cran.r-project.org/package=dplyr
"
KEYWORDS="~amd64"
DEPEND="
	dev-cpp/plog
	dev-libs/boost
	>=dev-lang/R-3.4.0
	dev-R/ellipsis
	dev-R/generics
	>=dev-R/glue-1.3.2
	>=dev-R/lifecycle-1.0.1
	>=dev-R/magrittr-1.5
	>=dev-R/pillar-1.5.1
	dev-R/R6
	>=dev-R/rlang-1.0.0
	>=dev-R/tibble-2.1.3
	>=dev-R/tidyselect-1.1.1
	>=dev-R/vctrs-0.3.5
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bench
	dev-R/broom
	dev-R/callr
	dev-R/covr
	dev-R/DBI
	>=dev-R/dplyr-1.4.3
	dev-R/ggplot2
	dev-R/knitr
	dev-R/Lahman
	dev-R/lobstr
	dev-R/microbenchmark
	dev-R/nycflights13
	dev-R/purrr
	dev-R/rmarkdown
	dev-R/RMySQLRPostgreSQL
	dev-R/RSQLite
	>=dev-R/testthat-3.1.1
	dev-R/tidyr
	dev-R/withr
"
