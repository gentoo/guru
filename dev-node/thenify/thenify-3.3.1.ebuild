# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Promisify a callback-based function"
HOMEPAGE="
	https://github.com/thenables/thenify
	https://www.npmjs.com/package/thenify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/any-promise
"
