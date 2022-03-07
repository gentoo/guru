# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Simple Data Frames'
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://tibble.tidyverse.org
	https://github.com/tidyverse/tibble
	https://cran.r-project.org/package=tibble
"

KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.1.0
	>=dev-R/ellipsis-0.3.2
	>=dev-R/fansi-0.4.0
	>=dev-R/lifecycle-1.0.0
	dev-R/magrittr
	>=dev-R/pillar-1.6.0
	dev-R/pkgconfig
	>=dev-R/rlang-0.4.3
	>=dev-R/vctrs-0.3.8
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bench
	dev-R/bit64
	dev-R/blob
	dev-R/brio
	dev-R/callr
	dev-R/cli
	dev-R/covr
	>=dev-R/crayon-1.3.4
	dev-R/DiagrammeR
	dev-R/dplyr
	dev-R/evaluate
	dev-R/formattable
	dev-R/ggplot2
	dev-R/hms
	dev-R/htmltools
	dev-R/knitr
	dev-R/lubridate
	dev-R/mockr
	dev-R/nycflights13
	dev-R/pkgbuild
	dev-R/purrr
	dev-R/rmarkdown
	dev-R/stringi
	>=dev-R/testthat-3.0.2
	dev-R/tidyr
	dev-R/withr
"
