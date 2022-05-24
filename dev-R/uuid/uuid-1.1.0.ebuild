# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

MYPV="$(ver_rs 2 -)"

DESCRIPTION='Tools for Generating and Handling of UUIDs'
HOMEPAGE="
	https://github.com/s-u/uuid
	https://www.rforge.net/uuid
	https://cran.r-project.org/package=uuid
"
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"

KEYWORDS="~amd64"
LICENSE='MIT'
