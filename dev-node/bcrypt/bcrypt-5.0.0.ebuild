# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A bcrypt library for NodeJS."
HOMEPAGE="
	https://github.com/kelektiv/node.bcrypt.js
	https://www.npmjs.com/package/bcrypt
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/node-pre-gyp
	dev-node/node-addon-api
"
