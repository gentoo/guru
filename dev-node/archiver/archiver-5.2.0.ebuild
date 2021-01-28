# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a streaming interface for archive generation"
HOMEPAGE="
	https://github.com/archiverjs/node-archiver
	https://www.npmjs.com/package/archiver
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/archiver-utils
	dev-node/async
	dev-node/buffer-crc32
	dev-node/readable-stream
	dev-node/readdir-glob
	dev-node/tar-stream
	dev-node/zip-stream
"
