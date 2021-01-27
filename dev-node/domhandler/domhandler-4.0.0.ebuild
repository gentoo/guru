# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Handler for htmlparser2 that turns pages into a dom"
HOMEPAGE="
	https://github.com/fb55/domhandler
	https://www.npmjs.com/package/domhandler
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/domelementtype
"
