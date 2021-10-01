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
PATCHES=( "${FILESDIR}/uuid8.patch" )
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/aws-sign2
	dev-js/aws4
	dev-js/caseless
	dev-js/combined-stream
	dev-js/extend
	dev-js/forever-agent
	dev-js/form-data
	dev-js/har-validator
	dev-js/http-signature
	dev-js/is-typedarray
	dev-js/isstream
	dev-js/json-stringify-safe
	dev-js/mime-types
	dev-js/oauth-sign
	dev-js/performance-now
	dev-js/qs
	dev-js/safe-buffer
	dev-js/tough-cookie
	dev-js/tunnel-agent
	dev-js/uuid
"
