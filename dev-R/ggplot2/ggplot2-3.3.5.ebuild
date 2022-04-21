# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Create Elegant Data Visualisations using the grammar of graphics'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.3
	dev-R/digest
	dev-R/glue
	>=dev-R/gtable-0.1.1
	dev-R/isoband
	>=dev-R/rlang-0.4.10
	>=dev-R/scales-0.5.0
	dev-R/tibble
	>=dev-R/withr-2.0.0
	virtual/MASS
	virtual/mgcv
"
RDEPEND="${DEPEND}"

SUGGESTED_PACKAGES="
	dev-R/covr
	dev-R/ragg
	dev-R/dplyr
	dev-R/ggplot2movies
	dev-R/hexbin
	dev-R/Hmisc
	dev-R/interp
	dev-R/knitr
	virtual/lattice
	dev-R/mapproj
	dev-R/maps
	dev-R/maptools
	dev-R/multcomp
	dev-R/munsell
	virtual/nlme
	dev-R/profvis
	dev-R/quantreg
	dev-R/RColorBrewer
	dev-R/rgeos
	dev-R/rmarkdown
	virtual/rpart
	>=dev-R/sf-0.7.3
	>=dev-R/svglite-1.2.0.9001
	>=dev-R/testthat-2.1.0
	>=dev-R/vdiffr-1.0.0
	dev-R/xml2
"
