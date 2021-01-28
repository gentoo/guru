# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="utility functions for archiver"
HOMEPAGE="
	https://github.com/archiverjs/archiver-utils
	https://www.npmjs.com/package/archiver-utils
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
	dev-node/graceful-fs
	dev-node/lazystream
	dev-node/lodash_defaults
	dev-node/lodash_difference
	dev-node/lodash_flatten
	dev-node/lodash_isplainobject
	dev-node/lodash_union
	dev-node/normalize-path
	dev-node/readable-stream
"
