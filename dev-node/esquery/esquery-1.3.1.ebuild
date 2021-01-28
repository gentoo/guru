# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A query library for ECMAScript AST using a CSS selector like query language."
HOMEPAGE="
	https://github.com/estools/esquery/
	https://www.npmjs.com/package/esquery
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/estraverse
"
