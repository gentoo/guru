# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="DNS wrapper for node.js"
HOMEPAGE="
	https://github.com/bcoin-org/bdns
	https://www.npmjs.com/package/bdns
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
"
