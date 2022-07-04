# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='A Simple Package for Testing R Packages'
KEYWORDS="~amd64"
LICENSE='GPL-3'

SUGGESTED_PACKAGES="
	dev-R/rstudioapi
	dev-R/covr
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	R_LIBS="${T}/R" edo Rscript --vanilla test-all.R
}
