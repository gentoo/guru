# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A very fast streaming multipart parser for node.js"
HOMEPAGE="
	https://github.com/mscdex/dicer
	https://www.npmjs.com/package/dicer
"
KEYWORDS="~amd64"
LICENSE="MIT"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/streamsearch
"
