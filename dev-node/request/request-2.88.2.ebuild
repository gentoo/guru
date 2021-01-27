# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Simplified HTTP request client."
HOMEPAGE="
	https://github.com/request/request
	https://www.npmjs.com/package/request
"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/aws-sign2
	dev-node/aws4
	dev-node/caseless
	dev-node/combined-stream
	dev-node/extend
	dev-node/forever-agent
	dev-node/form-data
	dev-node/har-validator
	dev-node/http-signature
	dev-node/is-typedarray
	dev-node/isstream
	dev-node/json-stringify-safe
	dev-node/mime-types
	dev-node/oauth-sign
	dev-node/performance-now
	dev-node/qs
	dev-node/safe-buffer
	dev-node/tough-cookie
	dev-node/tunnel-agent
	dev-node/uuid
"