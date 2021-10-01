# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="browserify version of publicEncrypt & privateDecrypt"
HOMEPAGE="
	https://github.com/crypto-browserify/publicEncrypt
	https://www.npmjs.com/package/public-encrypt
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/browserify-rsa
	dev-js/create-hash
	dev-js/parse-asn1
	dev-js/randombytes
	dev-js/safe-buffer
"
