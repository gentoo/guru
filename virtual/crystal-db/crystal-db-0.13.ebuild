# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for Crystal database drivers"

SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres sqlite"

RDEPEND="
	>=dev-crystal/crystal-db-0.13
	<dev-crystal/crystal-db-0.14
	postgres? (
		>=dev-crystal/crystal-pg-0.28
		<dev-crystal/crystal-pg-0.29
	)
	sqlite? (
		>=dev-crystal/crystal-sqlite3-0.21.0
		<dev-crystal/crystal-sqlite3-0.22.0
	)
"
