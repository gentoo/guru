# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Scale Functions for Visualization'
KEYWORDS="~amd64"
LICENSE='MIT'

DEPEND="
	>=dev-lang/R-3.2
	dev-R/labeling
	dev-R/RColorBrewer
	>=dev-R/farver-2.0.3
	>=dev-R/munsell-0.5
	dev-R/lifecycle
	dev-R/R6
	dev-R/viridisLite
"
RDEPEND="${DEPEND}"
