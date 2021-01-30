# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="fs read and write streams based on minipass"
HOMEPAGE="
	https://github.com/npm/fs-minipass
	https://www.npmjs.com/package/fs-minipass
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/minipass
"
