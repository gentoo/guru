# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ECMAScript AST recursive visitor"
HOMEPAGE="
	https://github.com/estools/esrecurse
	https://www.npmjs.com/package/esrecurse
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/estraverse
"
