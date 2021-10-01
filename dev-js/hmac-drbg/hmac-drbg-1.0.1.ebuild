# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Deterministic random bit generator (hmac)"
HOMEPAGE="
	https://github.com/indutny/hmac-drbg
	https://www.npmjs.com/package/hmac-drbg
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hash_js
	dev-js/minimalistic-assert
	dev-js/minimalistic-crypto-utils
"
