# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="createECDH but browserifiable"
HOMEPAGE="
	https://github.com/crypto-browserify/createECDH
	https://www.npmjs.com/package/create-ecdh
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/elliptic
"
