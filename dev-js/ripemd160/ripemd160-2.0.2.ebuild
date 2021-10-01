# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Compute ripemd160 of bytes or strings."
HOMEPAGE="
	https://github.com/crypto-browserify/ripemd160
	https://www.npmjs.com/package/ripemd160
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hash-base
	dev-js/inherits
"
