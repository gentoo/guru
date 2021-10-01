# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="EC cryptography"
HOMEPAGE="
	https://github.com/indutny/elliptic
	https://www.npmjs.com/package/elliptic
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/brorand
	dev-js/hash_js
	dev-js/hmac-drbg
	dev-js/inherits
	dev-js/minimalistic-assert
	dev-js/minimalistic-crypto-utils
"
