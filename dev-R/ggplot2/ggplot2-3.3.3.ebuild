# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Create Elegant Data Visualisations using the grammar of graphics'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.2
	>=dev-R/scales-0.5.0
	>=dev-R/withr-2.0.0
	virtual/MASS
	dev-R/isoband
	dev-R/glue
	dev-R/digest
	>=dev-R/gtable-0.1.1
	virtual/mgcv
	>=dev-R/rlang-0.3.0
	dev-R/tibble
"
RDEPEND="${DEPEND}"
