# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Generic interruptible "parser" mixin for Transform & Writable streams"
HOMEPAGE="
	https://github.com/TooTallNate/node-stream-parser
	https://www.npmjs.com/package/stream-parser
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
"
