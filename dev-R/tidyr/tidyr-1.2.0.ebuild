# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Tidy Messy Data'
KEYWORDS="~amd64"
LICENSE='MIT'
DEPEND="
	>=dev-R/dplyr-1.0.0
	>=dev-R/ellipsis-0.1.0
	dev-R/glue
	dev-R/lifecycle
	dev-R/magrittr
	dev-R/purrr
	dev-R/rlang
	>=dev-R/tibble-2.1.1
	>=dev-R/tidyselect-1.1.0
	>=dev-R/vctrs-0.3.7
	>=dev-R/cpp11-0.4.0
"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/data_table
	dev-R/jsonlite
	dev-R/knitr
	dev-R/readr
	>=dev-R/repurrrsive-1.0.0
	dev-R/rmarkdown
	>=dev-R/testthat-3.0.0
"
