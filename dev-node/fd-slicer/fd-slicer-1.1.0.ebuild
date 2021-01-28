# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="safely create multiple ReadStream or WriteStream objects from the same file descriptor"
HOMEPAGE="
	https://github.com/andrewrk/node-fd-slicer
	https://www.npmjs.com/package/fd-slicer
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/pend
"
