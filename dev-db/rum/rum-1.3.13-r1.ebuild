# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

POSTGRES_COMPAT=( 9.6 10 11 12 13 14 15 16 )
POSTGRES_USEDEP="server"

inherit postgres-multi

DESCRIPTION="RUM access method - inverted index with additional information in posting lists"
HOMEPAGE="https://github.com/postgrespro/rum"
SRC_URI="https://github.com/postgrespro/rum/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="${POSTGRES_DEP}"
RDEPEND="${DEPEND}"

# Needs a running PostgreSQL server
RESTRICT="test"

src_prepare() {
	sed -i 's;^PG_CONFIG =;PG_CONFIG ?=;' Makefile || die
	postgres-multi_src_prepare
}

src_compile() {
	postgres-multi_foreach emake USE_PGXS=1
}

src_test() {
	postgres-multi_foreach emake USE_PGXS=1 installcheck
}

src_install() {
	postgres-multi_foreach emake USE_PGXS=1 DESTDIR="${D}" install
}
