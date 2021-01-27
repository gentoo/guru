# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The centralized logger package for Pelias."
HOMEPAGE="
	https://github.com/pelias/logger
	https://www.npmjs.com/package/pelias-logger
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/winston
	dev-node/pelias-config
"
