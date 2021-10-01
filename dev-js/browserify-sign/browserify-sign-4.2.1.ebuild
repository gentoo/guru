# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="adds node crypto signing for browsers"
HOMEPAGE="
	https://github.com/crypto-browserify/browserify-sign
	https://www.npmjs.com/package/browserify-sign
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/browserify-rsa
	dev-js/create-hash
	dev-js/create-hmac
	dev-js/elliptic
	dev-js/inherits
	dev-js/parse-asn1
	dev-js/readable-stream
	dev-js/safe-buffer
"
