# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="render dom nodes to string"
HOMEPAGE="
	https://github.com/cheeriojs/dom-renderer
	https://www.npmjs.com/package/dom-serializer
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/domelementtype
	dev-node/domhandler
	dev-node/entities
"
