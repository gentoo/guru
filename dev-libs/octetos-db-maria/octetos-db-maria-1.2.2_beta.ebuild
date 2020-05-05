# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_beta/-alpha.6}"
MYPN="${PN/-maria}"
MYP="${MYPN}-${MYPV}"

DESCRIPTION="C++ library for Database Acces."
HOMEPAGE="https://github.com/azaeldevel/octetos-db"
SRC_URI="https://github.com/azaeldevel/${MYPN}/archive/${MYPV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

DEPEND="dev-libs/octetos-core dev-db/mariadb-connector-c"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${MYP}"

src_prepare() {
	default
	eautoreconf -fi
}
