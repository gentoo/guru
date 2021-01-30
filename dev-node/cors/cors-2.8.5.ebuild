# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js CORS middleware"
HOMEPAGE="
	https://github.com/expressjs/cors
	https://www.npmjs.com/package/cors
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/object-assign
	dev-node/vary
"
