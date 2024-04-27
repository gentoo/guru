# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_alpha/-alpha}"

MYP="${PN}-${MYPV}"

DESCRIPTION="C++ library for Database Acces."
HOMEPAGE="https://github.com/azaeldevel/octetos-db-maria"
SRC_URI="https://github.com/azaeldevel/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MYP}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/octetos-db-abstract
	dev-db/mariadb-connector-c
	dev-db/mariadb:=
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf -fi
}

src_configure() {
	econf --with-gentoo
}
