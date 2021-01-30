# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="OAuth 2.0 authorization server toolkit for Node.js."
HOMEPAGE="
	https://github.com/jaredhanson/oauth2orize
	https://www.npmjs.com/package/oauth2orize
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/uid2
	dev-node/utils-merge
	dev-node/debug
"
