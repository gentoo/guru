# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Coloured Formatting for Columns'
HOMEPAGE="
	https://github.com/r-lib/pillar
	https://cran.r-project.org/package=pillar
"
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-3'
KEYWORDS="~amd64"

DEPEND="
	>=dev-R/cli-2.3.0
	>=dev-R/crayon-1.3.4
	>=dev-R/ellipsis-0.3.2
	dev-R/fansi
	dev-R/glue
	dev-R/lifecycle
	>=dev-R/rlang-0.3.0
	>=dev-R/utf8-1.1.0
	>=dev-R/vctrs-0.3.8
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/bit64
	dev-R/debugme
	dev-R/DiagrammeR
	dev-R/dplyr
	dev-R/formattable
	dev-R/ggplot2
	dev-R/knitr
	dev-R/lubridate
	dev-R/nanotime
	dev-R/nycflights13
	dev-R/palmerpenguins
	dev-R/rmarkdown
	dev-R/scales
	dev-R/stringi
	virtual/survival
	>=dev-R/testthat-3.1.1
	dev-R/tibble
	>=dev-R/units-0.7.2
	dev-R/vdiffr
	dev-R/withr
"
