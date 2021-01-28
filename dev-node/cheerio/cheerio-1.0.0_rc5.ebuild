# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPV="${PV/_rc/-rc.}"
MYP="${PN}-${MYPV}"
SRC_URI="https://registry.npmjs.org/${PN}/-/${MYP}.tgz"
DESCRIPTION="Tiny, fast, and elegant implementation of core jQuery designed specifically for the server"
HOMEPAGE="
	https://github.com/cheeriojs/cheerio
	https://www.npmjs.com/package/cheerio
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cheerio-select-tmp
	dev-node/dom-serializer
	dev-node/domhandler
	dev-node/entities
	dev-node/htmlparser2
	dev-node/parse5
	dev-node/parse5-htmlparser2-tree-adapter
"
