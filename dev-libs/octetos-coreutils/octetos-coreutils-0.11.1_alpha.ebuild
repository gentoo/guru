# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_alpha/-alpha}"
MYP="${PN}-${MYPV}"

DESCRIPTION="Similar to coreutils but is a C++ API."
HOMEPAGE="https://github.com/azaeldevel/octetos-coreutils"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"


DEPEND="dev-libs/octetos-core"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cunit"

S="${WORKDIR}/${MYP}"

src_prepare() {
	default
	eautoreconf -fi
}

src_configure() {
	econf
}
