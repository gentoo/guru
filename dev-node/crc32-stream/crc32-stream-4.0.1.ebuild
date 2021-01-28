# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a streaming CRC32 checksumer"
HOMEPAGE="
	https://github.com/archiverjs/node-crc32-stream
	https://www.npmjs.com/package/crc32-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/crc_32
	dev-node/readable-stream
"
