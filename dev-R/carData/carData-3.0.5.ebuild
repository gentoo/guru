# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION="Companion to Applied Regression Data Sets"
KEYWORDS="~amd64"
LICENSE='GPL-2 GPL-3'
CRAN_PV="$(ver_rs 2 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"

SUGGESTED_PACKAGES="
	dev-R/car
"
