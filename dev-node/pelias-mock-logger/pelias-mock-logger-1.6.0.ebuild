# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Mock logger for testing logging behavior in Pelias projects"
HOMEPAGE="
	https://github.com/pelias/mock-logger
	https://www.npmjs.com/package/pelias-mock-logger
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/lodash
"
