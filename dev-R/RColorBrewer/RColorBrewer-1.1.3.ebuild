# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

MYPV=$(ver_rs 2 -)

DESCRIPTION='ColorBrewer Palettes'
SRC_URI="mirror://cran/src/contrib/${PN}_${MYPV}.tar.gz"
KEYWORDS="~amd64"
LICENSE='Apache-2.0'
