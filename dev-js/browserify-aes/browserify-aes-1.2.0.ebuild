# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="aes, for browserify"
HOMEPAGE="
	https://github.com/crypto-browserify/browserify-aes
	https://www.npmjs.com/package/browserify-aes
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/buffer-xor
	dev-js/cipher-base
	dev-js/create-hash
	dev-js/evp_bytestokey
	dev-js/inherits
	dev-js/safe-buffer
"
