# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Global identifiers from different JavaScript environments"
HOMEPAGE="
	https://github.com/sindresorhus/globals
	https://www.npmjs.com/package/globals
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/type-fest
"
