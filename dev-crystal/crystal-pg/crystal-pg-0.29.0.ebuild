# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -Ag DAEMONS_REQ_USE=(
	[postgresql]="xml"
)
inherit daemons shards

DESCRIPTION="A native, non-blocking Postgres driver for Crystal"
HOMEPAGE="https://github.com/will/crystal-pg"
SRC_URI="https://github.com/will/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-crystal/crystal-db-0.13.0
	<dev-crystal/crystal-db-0.14.0
"

DOCS=( CHANGELOG CONTRIBUTORS {CONTRIBUTING,README}.md )

daemons_enable postgresql test

src_test() {
	daemons_start postgresql --host 127.0.0.1
	local -x DATABASE_URL="${POSTGRESQL_URL:?}"

	shards_src_test
	daemons_stop postgresql
}
