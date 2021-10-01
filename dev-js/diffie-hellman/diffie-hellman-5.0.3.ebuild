# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="pure js diffie-hellman"
HOMEPAGE="
	https://github.com/crypto-browserify/diffie-hellman
	https://www.npmjs.com/package/diffie-hellman
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/miller-rabin
	dev-js/randombytes
"
