# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Various Programming Utilities"
KEYWORDS="~amd64"
LICENSE='MPL-2.0'
CRAN_PN="data.table"
SRC_URI="mirror://cran/src/contrib/${CRAN_PN}_${PV}.tar.gz"

SUGGESTED_PACKAGES="
	>=dev-R/bit64-4.0.0
	>=dev-R/bit-4.0.4
	dev-R/curl
	dev-R/R_utils
	dev-R/xts
	dev-R/nanotime
	>=dev-R/zoo-1.8.1
	dev-R/yaml
	dev-R/knitr
	dev-R/rmarkdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla main.R
}
