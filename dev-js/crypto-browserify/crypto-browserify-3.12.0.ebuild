# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="implementation of crypto for the browser"
HOMEPAGE="
	https://github.com/crypto-browserify/crypto-browserify
	https://www.npmjs.com/package/crypto-browserify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/browserify-cipher
	dev-js/browserify-sign
	dev-js/create-ecdh
	dev-js/create-hash
	dev-js/create-hmac
	dev-js/diffie-hellman
	dev-js/inherits
	dev-js/pbkdf2
	dev-js/public-encrypt
	dev-js/randombytes
	dev-js/randomfill
"
