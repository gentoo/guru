# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="bash npm install naivedb --save "
HOMEPAGE="
	https://github.com/missinglink/naivedb
	https://www.npmjs.com/package/naivedb
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/through2
"
