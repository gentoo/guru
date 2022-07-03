# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Unified Parallel and Distributed Processing in R for Everyone"
KEYWORDS="~amd64"
LICENSE='LGPL-2.1+'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	dev-R/digest
	>=dev-R/globals-0.15.0
	>=dev-R/listenv-0.8.0
	>=dev-R/parallelly-1.30.0
	test? ( dev-R/RhpcBLASctl )
"

SUGGESTED_PACKAGES="
	dev-R/RhpcBLASctl
	dev-R/R-rsp
	dev-R/markdown
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	for i in *.R; do
		R_LIBS="${T}/R" edo Rscript --vanilla $i
	done
}
