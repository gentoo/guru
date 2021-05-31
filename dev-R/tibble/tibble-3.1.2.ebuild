# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='Simple Data Frames'
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='MIT'
HOMEPAGE="
	https://tibble.tidyverse.org
	https://github.com/tidyverse/tibble
	https://cran.r-project.org/package=tibble
"

KEYWORDS="~amd64"
DEPEND="
	>=dev-lang/R-3.1.0
	>=dev-R/ellipsis-0.3.2
	>=dev-R/fansi-0.4.0
	>=dev-R/lifecycle-0.2.0
	dev-R/magrittr
	>=dev-R/pillar-1.6.0
	dev-R/pkgconfig
	>=dev-R/rlang-0.4.3
	>=dev-R/vctrs-0.3.8
"
RDEPEND="${DEPEND}"
