# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parse HTTP request cookies"
HOMEPAGE="
	https://github.com/expressjs/cookie-parser
	https://www.npmjs.com/package/cookie-parser
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cookie
	dev-node/cookie-signature
"
