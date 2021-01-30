# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Simple session middleware for Express"
HOMEPAGE="
	https://github.com/expressjs/session
	https://www.npmjs.com/package/express-session
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cookie
	dev-node/cookie-signature
	dev-node/debug
	dev-node/depd
	dev-node/on-headers
	dev-node/parseurl
	dev-node/safe-buffer
	dev-node/uid-safe
"
