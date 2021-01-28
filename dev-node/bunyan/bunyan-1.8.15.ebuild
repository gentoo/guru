# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a JSON logging library for node.js services"
HOMEPAGE="
	https://github.com/trentm/node-bunyan
	https://www.npmjs.com/package/bunyan
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/dtrace-provider
	dev-node/mv
	dev-node/safe-json-stringify
	dev-node/moment
"
