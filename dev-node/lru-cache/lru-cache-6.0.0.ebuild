# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A cache object that deletes the least-recently-used items."
HOMEPAGE="
	https://github.com/isaacs/node-lru-cache
	https://www.npmjs.com/package/lru-cache
"
SRC_URI="https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/yallist
"
