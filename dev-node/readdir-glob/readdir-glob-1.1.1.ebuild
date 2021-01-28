# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Recursive fs.readdir with streaming API and glob filtering."
HOMEPAGE="
	https://github.com/Yqnn/node-readdir-glob
	https://www.npmjs.com/package/readdir-glob
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/minimatch
"
