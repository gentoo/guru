# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='A Grammar of Data Manipulation'
SRC_URI="http://cran.r-project.org/src/contrib/dplyr_0.8.5.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://dplyr.tidyverse.org
	https://github.com/tidyverse/dplyr
	https://cran.r-project.org/package=dplyr
"
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND="
	dev-cpp/plog
	dev-libs/boost
	>=dev-lang/R-3.2.0
	>=dev-R/assertthat-0.2.0
	dev-R/ellipsis
	>=dev-R/glue-1.3.0
	>=dev-R/magrittr-1.5
	dev-R/pkgconfig
	dev-R/R6
	>=dev-R/Rcpp-1.0.1
	>=dev-R/rlang-0.4.0
	>=dev-R/tibble-2.0.0
	>=dev-R/tidyselect-0.2.5
"
RDEPEND="${DEPEND-}"
