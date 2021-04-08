# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages-guru

DESCRIPTION='Helpers for Developing Command Line Interfaces'
HOMEPAGE="
	https://github.com/r-lib/cli
	https://cran.r-project.org/package=cli
"
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='MIT'
KEYWORDS="~amd64"
IUSE="${IUSE-}"
DEPEND="
	>=dev-lang/R-2.1.0
	dev-R/assertthat
	dev-R/glue
"
RDEPEND="${DEPEND-}"
