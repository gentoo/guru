# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_alpha/-alpha}"
MYPN="${PN}"
MYP="${MYPN}-${MYPV}"

DESCRIPTION="API to access database, abstract component."
HOMEPAGE="https://github.com/azaeldevel/octetos-db-abstract"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"


DEPEND="dev-libs/octetos-core"
RDEPEND="
	${DEPEND}
	!!dev-libs/octetos-db
"

S="${WORKDIR}/${MYP}"

src_prepare() {
	default
	eautoreconf -fi
}

src_configure() {
	econf
}
