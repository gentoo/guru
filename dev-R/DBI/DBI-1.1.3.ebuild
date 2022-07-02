# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='R Database Interface'
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'

SUGGESTED_PACKAGES="
	dev-R/blob
	dev-R/covr
	dev-R/DBItest
	dev-R/dbplyr
	dev-R/downlit
	dev-R/dplyr
	dev-R/glue
	dev-R/hms
	dev-R/knitr
	dev-R/magrittr
	dev-R/RMariaDB
	dev-R/rmarkdown
	dev-R/rprojroot
	>=dev-R/RSQLite-1.1.2
	dev-R/testthat
	dev-R/xml2
"
