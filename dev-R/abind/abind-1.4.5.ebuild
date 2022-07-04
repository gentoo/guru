# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Unified Parallel and Distributed Processing in R for Everyone"
KEYWORDS="~amd64"
LICENSE='LGPL-2+'
CRAN_PV="$(ver_rs 2 -)"
SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	for i in *.R; do
		R_LIBS="${T}/R" edo Rscript --vanilla $i
	done
}
