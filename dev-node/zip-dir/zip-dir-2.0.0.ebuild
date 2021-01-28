# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Zips up directories into buffers or saves zipped files to disk"
HOMEPAGE="
	https://github.com/jsantell/node-zip-dir
	https://www.npmjs.com/package/zip-dir
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jszip
	dev-node/async
"
