# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="create hashes for browserify"
HOMEPAGE="
	https://github.com/crypto-browserify/createHash
	https://www.npmjs.com/package/create-hash
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/cipher-base
	dev-js/inherits
	dev-js/md5_js
	dev-js/ripemd160
	dev-js/sha_js
"
