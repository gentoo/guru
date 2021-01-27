# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Portable Unix shell commands for Node.js"
HOMEPAGE="
	https://github.com/shelljs/shelljs
	https://www.npmjs.com/package/shelljs
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
	dev-node/interpret
	dev-node/rechoir
"
