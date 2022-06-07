# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="OpenMP Pragma And Region Instrumentor"
HOMEPAGE="https://www.vi-hps.org/projects/score-p"
SRC_URI="https://perftools.pages.jsc.fz-juelich.de/cicd/${PN}/tags/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	dodoc OPEN_ISSUES README
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
