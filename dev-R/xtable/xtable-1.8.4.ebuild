# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Export Tables to LaTeX or HTML"
KEYWORDS="~amd64"
LICENSE='GPL-2+'
RESTRICT="!test? ( test )"
IUSE="test"
CRAN_PV="$(ver_rs 2 -)"

SRC_URI="mirror://cran/src/contrib/${PN}_${CRAN_PV}.tar.gz"

SUGGESTED_PACKAGES="
	dev-R/knitr
	dev-R/plm
	dev-R/zoo
	dev-R/survival
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	for i in *.R; do
		R_LIBS="${T}/R" edo Rscript --vanilla $i
	done
}
