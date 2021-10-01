# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="browserify-des ==="
HOMEPAGE="
	https://github.com/crypto-browserify/browserify-des
	https://www.npmjs.com/package/browserify-des
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/cipher-base
	dev-js/des_js
	dev-js/inherits
	dev-js/safe-buffer
"
