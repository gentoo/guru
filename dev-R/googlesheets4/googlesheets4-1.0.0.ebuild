# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Access Google Sheets using the Sheets API V4'
HOMEPAGE="
	https://cran.r-project.org/package=googlesheets4
	https://googlesheets4.tidyverse.org/
	https://github.com/tidyverse/googlesheets4
"
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	dev-R/cellranger
	dev-R/ids
	dev-R/magrittr
	>=dev-R/googledrive-2.0.0
	>=dev-R/glue-1.3.0
	dev-R/purrr
	>=dev-R/rlang-0.4.11
	>=dev-lang/R-3.3
	>=dev-R/cli-3.0.0
	dev-R/curl
	>=dev-R/gargle-1.2.0
	dev-R/httr
	dev-R/rematch2
	>=dev-R/tibble-2.1.1
	>=dev-R/vctrs-0.2.3
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/readr
	dev-R/rmarkdown
	dev-R/spelling
	>=dev-R/testthat-3.0.0
	dev-R/withr
"
