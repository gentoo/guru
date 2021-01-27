# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a little globber"
HOMEPAGE="
	https://github.com/isaacs/node-glob
	https://www.npmjs.com/package/glob
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/fs_realpath
	dev-node/inflight
	dev-node/inherits
	dev-node/minimatch
	dev-node/once
	dev-node/path-is-absolute
"