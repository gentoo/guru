# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Miller Rabin algorithm for primality test"
HOMEPAGE="
	https://github.com/indutny/miller-rabin
	https://www.npmjs.com/package/miller-rabin
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/brorand
"
