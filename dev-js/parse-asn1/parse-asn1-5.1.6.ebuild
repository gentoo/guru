# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="utility library for parsing asn1 files for use with browserify-sign."
HOMEPAGE="
	https://github.com/crypto-browserify/parse-asn1
	https://www.npmjs.com/package/parse-asn1
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/asn1_js
	dev-js/browserify-aes
	dev-js/evp_bytestokey
	dev-js/pbkdf2
	dev-js/safe-buffer
"
