# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Fast & forgiving HTML/XML parser"
HOMEPAGE="
	https://github.com/fb55/htmlparser2
	https://www.npmjs.com/package/htmlparser2
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/domelementtype
	dev-node/domhandler
	dev-node/domutils
	dev-node/entities
"
