# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION="'Asio' C++ Header Files"
KEYWORDS="~amd64"
LICENSE='Boost-1.0'
CRAN_PV="$(ver_rs 3 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"
