# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The insecure key derivation algorithm from OpenSSL"
HOMEPAGE="
	https://github.com/crypto-browserify/EVP_BytesToKey
	https://www.npmjs.com/package/evp_bytestokey
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/md5_js
	dev-js/safe-buffer
"
