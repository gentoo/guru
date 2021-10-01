# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ciphers for the browser"
HOMEPAGE="
	https://github.com/crypto-browserify/browserify-cipher
	https://www.npmjs.com/package/browserify-cipher
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/browserify-aes
	dev-js/browserify-des
	dev-js/evp_bytestokey
"
