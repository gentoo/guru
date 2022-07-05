# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Derivative-free optimization algorithms by quadratic approximation"
KEYWORDS="~amd64"
LICENSE='GPL-2'

DEPEND="
	dev-R/Rcpp
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	for i in *.R; do
		R_LIBS="${T}/R" edo Rscript --vanilla $i
	done
}
