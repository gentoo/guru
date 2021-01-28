# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Human-friendly and powerful HTTP request library for Node.js"
HOMEPAGE="
	https://github.com/sindresorhus/got
	https://www.npmjs.com/package/got
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/sindresorhus+is
	dev-node/szmarczak+http-timer
	dev-node/types+cacheable-request
	dev-node/types+responselike
	dev-node/cacheable-lookup
	dev-node/cacheable-request
	dev-node/decompress-response
	dev-node/http2-wrapper
	dev-node/lowercase-keys
	dev-node/p-cancelable
	dev-node/responselike
"
