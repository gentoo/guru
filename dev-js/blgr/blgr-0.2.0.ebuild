# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Logger for node.js"
HOMEPAGE="
	https://github.com/bcoin-org/blgr
	https://www.npmjs.com/package/blgr
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
"
