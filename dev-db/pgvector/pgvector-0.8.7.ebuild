# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( 18 )
POSTGRES_USEDEP="server"

inherit postgres-multi

DESCRIPTION="Open-source vector similarity search for Postgres"
HOMEPAGE="https://github.com/pgvector/pgvector"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="${POSTGRES_DEP}"
RDEPEND="${DEPEND}"

# Needs a running PostgreSQL server
RESTRICT="test"

src_prepare() {
	postgres-multi_src_prepare
}

src_compile() {
	postgres-multi_foreach emake
}

src_test() {
	postgres-multi_foreach emake installcheck
}

src_install() {
	postgres-multi_foreach emake DESTDIR="${D}" install
}
