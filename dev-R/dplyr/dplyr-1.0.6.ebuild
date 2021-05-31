# Copyright 1999-2021 Gentoo Authors
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
	>=dev-lang/R-3.3.0
	dev-R/ellipsis
	dev-R/generics
	>=dev-R/glue-1.3.2
	>=dev-R/lifecycle-1.0.0
	>=dev-R/magrittr-1.5
	>=dev-R/pillar-1.5.1
	dev-R/R6
	>=dev-R/rlang-0.4.10
	>=dev-R/tibble-2.1.3
	>=dev-R/tidyselect-1.1.0
	>=dev-R/vctrs-0.3.5
"
RDEPEND="${DEPEND}"
