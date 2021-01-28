# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="CSS selector engine supporting jQuery selectors"
HOMEPAGE="
	https://github.com/cheeriojs/cheerio-select
	https://www.npmjs.com/package/cheerio-select-tmp
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/css-select
	dev-node/css-what
	dev-node/domelementtype
	dev-node/domhandler
	dev-node/domutils
"
