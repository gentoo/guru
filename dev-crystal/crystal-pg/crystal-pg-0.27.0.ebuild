# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit databases edo shards

DESCRIPTION="A native, non-blocking Postgres driver for Crystal"
HOMEPAGE="https://github.com/will/crystal-pg"
SRC_URI="https://github.com/will/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-crystal/crystal-db"
BDEPEND="test? ( ${DATABASES_DEPEND[postgres]} )"

DOCS=( CHANGELOG CONTRIBUTORS {CONTRIBUTING,README}.md )

src_test() {
	local -x DATABASE_URL="postgres://postgres@127.0.0.1:65432/testdb"

	epostgres --start 65432
	edo createdb -h 127.0.0.1 -p 65432 -U postgres testdb
	shards_src_test
	epostgres --stop
}
