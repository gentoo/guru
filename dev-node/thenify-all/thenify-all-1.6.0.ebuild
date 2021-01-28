# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Promisifies all the selected functions in an object"
HOMEPAGE="
	https://github.com/thenables/thenify-all
	https://www.npmjs.com/package/thenify-all
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/thenify
"
