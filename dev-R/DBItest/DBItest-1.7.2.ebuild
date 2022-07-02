# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Testing DBI Backends'
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'
DEPEND="
	>=dev-R/blob-1.2.0
	dev-R/callr
	>=dev-R/DBI-1.1.1
	dev-R/desc
	>=dev-R/hms-0.5.0
	dev-R/lubridate
	dev-R/palmerpenguins
	dev-R/R6
	>=dev-R/rlang-0.2.0
	>=dev-R/testthat-2.0.0
	dev-R/withr
	dev-R/vctrs
"

SUGGESTED_PACKAGES="
	dev-R/clipr
	>=dev-R/dblog-0.0.0.9008
	dev-R/debugme
	dev-R/devtools
	dev-R/knitr
	dev-R/lintr
	dev-R/rmarkdown
	dev-R/RSQLite
"
