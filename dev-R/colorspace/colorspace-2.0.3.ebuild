# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MYPV="$(ver_rs 2 -)"

inherit R-packages

DESCRIPTION='A Toolbox for Manipulating and Assessing colors and palettes'
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='BSD'

DEPEND=">=dev-lang/R-3.0.0"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	virtual/KernSmooth
	virtual/MASS
	dev-R/kernlab
	dev-R/mvtnorm
	dev-R/vcd
	dev-R/shiny
	dev-R/shinyjs
	dev-R/ggplot2
	dev-R/dplyr
	dev-R/scales
	dev-R/png
	dev-R/jpeg
	dev-R/knitr
	dev-R/rmarkdown
	dev-R/RColorBrewer
	dev-R/rcartocolor
	dev-R/scico
	dev-R/viridis
	dev-R/weseanderson
"
