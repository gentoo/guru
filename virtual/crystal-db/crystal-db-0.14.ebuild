# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for Crystal database drivers"

SLOT="0"
KEYWORDS="~amd64"
IUSE="postgres sqlite"

RDEPEND="
	>=dev-crystal/crystal-db-0.14
	<dev-crystal/crystal-db-0.15
	postgres? (
		>=dev-crystal/crystal-pg-0.29
		<dev-crystal/crystal-pg-0.30
	)
	sqlite? (
		>=dev-crystal/crystal-sqlite3-0.22.0
		<dev-crystal/crystal-sqlite3-0.23.0
	)
"
