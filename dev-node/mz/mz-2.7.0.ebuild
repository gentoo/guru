# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="modernize node.js to current ECMAScript standards"
HOMEPAGE="
	https://github.com/normalize/mz
	https://www.npmjs.com/package/mz
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/any-promise
	dev-node/object-assign
	dev-node/thenify-all
"
