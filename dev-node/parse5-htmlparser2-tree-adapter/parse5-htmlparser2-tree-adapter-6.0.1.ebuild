# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="htmlparser2 tree adapter for parse5."
HOMEPAGE="
	https://github.com/inikulin/parse5
	https://www.npmjs.com/package/parse5-htmlparser2-tree-adapter
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/parse5
"
