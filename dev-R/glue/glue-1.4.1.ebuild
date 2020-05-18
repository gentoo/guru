# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Interpreted String Literals'
HOMEPAGE="
	https://glue.tidyverse.org
	https://github.com/tidyverse/glue
	https://cran.r-project.org/package=glue
"
SRC_URI="http://cran.r-project.org/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='MIT'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND=">=dev-lang/R-3.1"
RDEPEND="${DEPEND}"
