# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="This library provides the functionality of PBKDF2 with the ability to use any supported hashing algorithm returned from crypto.getHashes()"
HOMEPAGE="
	https://github.com/crypto-browserify/pbkdf2
	https://www.npmjs.com/package/pbkdf2
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/create-hash
	dev-js/create-hmac
	dev-js/ripemd160
	dev-js/safe-buffer
	dev-js/sha_js
"
