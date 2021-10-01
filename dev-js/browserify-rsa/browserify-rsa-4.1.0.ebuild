# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="RSA for browserify"
HOMEPAGE="
	https://github.com/crypto-browserify/browserify-rsa
	https://www.npmjs.com/package/browserify-rsa
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/randombytes
"
