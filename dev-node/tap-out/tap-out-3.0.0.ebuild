# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A different tap parser"
HOMEPAGE="
	https://github.com/scottcorgan/tap-out
	https://www.npmjs.com/package/tap-out
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/re-emitter
	dev-node/readable-stream
	dev-node/split
	dev-node/trim
"

PATCHES=( "${FILESDIR}/PassThrough.patch" )
