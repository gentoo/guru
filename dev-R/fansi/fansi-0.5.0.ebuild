# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit R-packages

DESCRIPTION='ANSI Control Sequence Aware String Functions'
HOMEPAGE="
	https://github.com/brodieG/fansi
	https://cran.r-project.org/package=fansi
"
SRC_URI="mirror://cran/src/contrib/${PN}_${PV}.tar.gz"
LICENSE='GPL-2+'
KEYWORDS="~amd64"

DEPEND=">=dev-lang/R-3.1.0"
RDEPEND="${DEPEND}"
