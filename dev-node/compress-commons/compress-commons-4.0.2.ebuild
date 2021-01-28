# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a library that defines a common interface for working with archive formats within node"
HOMEPAGE="
	https://github.com/archiverjs/node-compress-commons
	https://www.npmjs.com/package/compress-commons
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/buffer-crc32
	dev-node/crc32-stream
	dev-node/normalize-path
	dev-node/readable-stream
"
