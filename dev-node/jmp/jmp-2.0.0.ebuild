# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js module for creating, parsing and replying to messages of the Jupyter Messaging Protocol (JMP)"
HOMEPAGE="
	https://github.com/n-riesco/jmp
	https://www.npmjs.com/package/jmp
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/uuid
	dev-node/zeromq
"
