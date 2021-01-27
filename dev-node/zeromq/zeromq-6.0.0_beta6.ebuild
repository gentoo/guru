# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPV="${PV/_beta/-beta.}"
MYP="${PN}-${MYPV}"
SRC_URI="https://registry.npmjs.org/${PN}/-/${MYP}.tgz"
DESCRIPTION="Next-generation ZeroMQ bindings for Node.js"
HOMEPAGE="
	https://github.com/zeromq/zeromq.js
	https://www.npmjs.com/package/zeromq
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/node-gyp-build
"
