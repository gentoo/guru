# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Open Node Streams on demand."
HOMEPAGE="
	https://github.com/jpommerening/node-lazystream
	https://www.npmjs.com/package/lazystream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/readable-stream
"
