# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A small fast zlib stream built on [minipass](http://npm.im/minipass) and Node.js's zlib binding."
HOMEPAGE="
	https://github.com/isaacs/minizlib
	https://www.npmjs.com/package/minizlib
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/minipass
	dev-node/yallist
"
