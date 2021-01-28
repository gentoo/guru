# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="deep copy data"
HOMEPAGE="
	https://github.com/sasaplus1/deepcopy.js
	https://www.npmjs.com/package/deepcopy
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/type-detect
"
