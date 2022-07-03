# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION='Environments Behaving (Almost) as Lists'
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'

SUGGESTED_PACKAGES="
	dev-R/R-utils
	dev-R/R-rsp
	dev-R/markdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	for i in *.R; do
		R_LIBS="${T}/R" edo Rscript --vanilla $i
	done
}
