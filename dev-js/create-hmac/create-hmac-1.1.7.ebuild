# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="node style hmacs in the browser"
HOMEPAGE="
	https://github.com/crypto-browserify/createHmac
	https://www.npmjs.com/package/create-hmac
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/cipher-base
	dev-js/create-hash
	dev-js/inherits
	dev-js/ripemd160
	dev-js/safe-buffer
	dev-js/sha_js
"
