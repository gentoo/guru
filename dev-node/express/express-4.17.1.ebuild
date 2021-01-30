# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Fast, unopinionated, minimalist web framework"
HOMEPAGE="
	http://expressjs.com/
	https://www.npmjs.com/package/express
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/accepts
	dev-node/array-flatten
	dev-node/body-parser
	dev-node/content-disposition
	dev-node/content-type
	dev-node/cookie
	dev-node/cookie-signature
	dev-node/debug
	dev-node/depd
	dev-node/encodeurl
	dev-node/escape-html
	dev-node/etag
	dev-node/finalhandler
	dev-node/fresh
	dev-node/merge-descriptors
	dev-node/methods
	dev-node/on-finished
	dev-node/parseurl
	dev-node/path-to-regexp
	dev-node/proxy-addr
	dev-node/qs
	dev-node/range-parser
	dev-node/safe-buffer
	dev-node/send
	dev-node/serve-static
	dev-node/setprototypeof
	dev-node/statuses
	dev-node/type-is
	dev-node/utils-merge
	dev-node/vary
"
