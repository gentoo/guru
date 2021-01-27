# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Is this specifier a node.js core module?"
HOMEPAGE="
	https://github.com/inspect-js/is-core-module
	https://www.npmjs.com/package/is-core-module
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/has
"
