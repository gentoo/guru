# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages

DESCRIPTION="Control the Number of Threads on 'BLAS'"
KEYWORDS="~amd64"
LICENSE='AGPL-3'
CRAN_PV="$(ver_rs 2 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"
