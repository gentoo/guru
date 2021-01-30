# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Simple, unobtrusive authentication for Node.js."
HOMEPAGE="
	http://passportjs.org/
	https://www.npmjs.com/package/passport
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/passport-strategy
	dev-node/pause
"
