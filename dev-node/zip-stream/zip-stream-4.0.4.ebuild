# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a streaming zip archive generator."
HOMEPAGE="
	https://github.com/archiverjs/node-zip-stream
	https://www.npmjs.com/package/zip-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/archiver-utils
	dev-node/compress-commons
	dev-node/readable-stream
"
