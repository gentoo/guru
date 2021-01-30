# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="node.js basic auth parser"
HOMEPAGE="
	https://github.com/jshttp/basic-auth
	https://www.npmjs.com/package/basic-auth
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/safe-buffer
"
