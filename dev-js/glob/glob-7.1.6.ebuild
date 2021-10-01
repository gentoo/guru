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
	dev-js/fs_realpath
	dev-js/inflight
	dev-js/inherits
	dev-js/minimatch
	dev-js/once
	dev-js/path-is-absolute
"
