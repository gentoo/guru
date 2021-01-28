# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Wrap native HTTP requests with RFC compliant cache support"
HOMEPAGE="
	https://github.com/lukechilds/cacheable-request
	https://www.npmjs.com/package/cacheable-request
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/clone-response
	dev-node/get-stream
	dev-node/http-cache-semantics
	dev-node/keyv
	dev-node/lowercase-keys
	dev-node/normalize-url
	dev-node/responselike
"
