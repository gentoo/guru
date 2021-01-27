# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Node.js taginfo interface"
HOMEPAGE="
	https://github.com/oddityoverseer13/node-taginfo
	https://www.npmjs.com/package/taginfo
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/merge
	dev-node/request
"
