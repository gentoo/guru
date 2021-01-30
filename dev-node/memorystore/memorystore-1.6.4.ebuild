# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="express-session full featured MemoryStore layer without leaks!"
HOMEPAGE="
	https://github.com/roccomuso/memorystore
	https://www.npmjs.com/package/memorystore
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
	dev-node/lru-cache
"
