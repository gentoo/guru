# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a glob matcher in javascript"
HOMEPAGE="
	https://github.com/isaacs/minimatch
	https://www.npmjs.com/package/minimatch
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/brace-expansion
"