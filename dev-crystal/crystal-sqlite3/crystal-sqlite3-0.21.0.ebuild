# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="SQLite3 bindings for Crystal"
HOMEPAGE="https://github.com/crystal-lang/crystal-sqlite3"
SRC_URI="https://github.com/crystal-lang/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-crystal/crystal-db-0.13.0
	<dev-crystal/crystal-db-0.14.0
"

DOCS=( {CHANGELOG,README}.md )
