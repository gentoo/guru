# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='An Interface to Google Drive'
HOMEPAGE="
	https://cran.r-project.org/package=googledrive
	https://googledrive.tidyverse.org/
	https://github.com/tidyverse/googledrive
"

KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-R/cli-3.0.0
	dev-R/pillar
	dev-R/lifecycle
	dev-R/magrittr
	>=dev-R/glue-1.4.2
	>=dev-R/rlang-0.4.9
	dev-R/uuid
	>=dev-lang/R-3.3
	>=dev-R/gargle-1.2.0
	dev-R/httr
	dev-R/jsonlite
	>=dev-R/purrr-0.2.3
	>=dev-R/tibble-2.0.0
	>=dev-R/vctrs-0.3.0
	dev-R/withr
"
RDEPEND="${DEPEND}"

R_SUGGESTS="
	dev-R/covr
	dev-R/curl
	dev-R/downlit
	>=dev-R/dplyr-1.0.0
	dev-R/knitr
	dev-R/mockr
	dev-R/rmarkdown
	dev-R/roxygen2
	dev-R/spelling
	>=dev-R/testthat-3.0.0
"
