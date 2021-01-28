# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Import a module while bypassing the cache"
HOMEPAGE="
	https://github.com/sindresorhus/import-fresh
	https://www.npmjs.com/package/import-fresh
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/parent-module
	dev-node/resolve-from
"
