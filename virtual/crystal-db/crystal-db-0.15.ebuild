# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Virtual for Crystal database drivers"

SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres sqlite"

RDEPEND="
	>=dev-crystal/crystal-db-0.15
	<dev-crystal/crystal-db-0.16
	postgres? (
		>=dev-crystal/crystal-pg-0.31
		<dev-crystal/crystal-pg-0.32
	)
	sqlite? (
		>=dev-crystal/crystal-sqlite3-0.24.0
		<dev-crystal/crystal-sqlite3-0.25.0
	)
"
