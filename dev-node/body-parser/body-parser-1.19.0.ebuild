# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js body parsing middleware"
HOMEPAGE="
	https://github.com/expressjs/body-parser
	https://www.npmjs.com/package/body-parser
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/bytes
	dev-node/content-type
	dev-node/debug
	dev-node/depd
	dev-node/http-errors
	dev-node/iconv-lite
	dev-node/on-finished
	dev-node/qs
	dev-node/raw-body
	dev-node/type-is
"
