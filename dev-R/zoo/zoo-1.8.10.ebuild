# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION="S3 Infrastructure for Regular and Irregular Time Series (Z's Ordered Observations)"
KEYWORDS="~amd64"
LICENSE='GPL-2 GPL-3'
CRAN_PV="$(ver_rs 2 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"

DEPEND="
	virtual/lattice
"

SUGGESTED_PACKAGES="
	dev-R/AER
	dev-R/coda
	dev-R/chron
	>=dev-R/ggplot2-3.0.0
	dev-R/mondate
	dev-R/scales
	dev-R/stinepack
	dev-R/strucchange
	dev-R/timeDate
	dev-R/timeSeries
	dev-R/tis
	dev-R/tseries
	dev-R/xts
"
