# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js final http responder"
HOMEPAGE="
	https://github.com/pillarjs/finalhandler
	https://www.npmjs.com/package/finalhandler
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
	dev-node/encodeurl
	dev-node/escape-html
	dev-node/on-finished
	dev-node/parseurl
	dev-node/statuses
	dev-node/unpipe
"
