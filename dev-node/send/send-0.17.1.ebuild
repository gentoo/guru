# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Better streaming static file server with Range and conditional-GET support"
HOMEPAGE="
	https://github.com/pillarjs/send
	https://www.npmjs.com/package/send
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
	dev-node/depd
	dev-node/destroy
	dev-node/encodeurl
	dev-node/escape-html
	dev-node/etag
	dev-node/fresh
	dev-node/http-errors
	dev-node/mime
	dev-node/ms
	dev-node/on-finished
	dev-node/range-parser
	dev-node/statuses
"
