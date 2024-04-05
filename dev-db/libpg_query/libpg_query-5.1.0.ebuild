# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PG_TARGET="16"
MY_PV="${PG_TARGET}-${PV}"
DESCRIPTION="C library for accessing the PostgreSQL parser outside of the server environment"
HOMEPAGE="https://github.com/pganalyze/libpg_query"
SRC_URI="https://github.com/pganalyze/libpg_query/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0/${PG_TARGET}"
KEYWORDS="~amd64"
IUSE="examples"

BDEPEND="
	dev-libs/protobuf-c
	dev-libs/xxhash
"

src_compile() {
	emake build
	emake build_shared
	use examples && emake examples
}

src_test() {
	emake test
}

src_install() {
	emake \
		prefix="${ED}"/usr \
		libdir="${ED}/usr/$(get_libdir)" \
		install
}
