# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION='Tools for Parsing and Generating XML Within R and S-Plus'
KEYWORDS="~amd64"
LICENSE='BSD'
DEPEND="
	>=dev-libs/libxml2-2.6.3
"
CRAN_PV="$(ver_rs 2 -)"

SUGGESTED_PACKAGES="
	dev-R/bitops
	dev-R/RCurl
"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"
