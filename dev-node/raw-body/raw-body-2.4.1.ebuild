# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get and validate the raw body of a readable stream."
HOMEPAGE="
	https://github.com/stream-utils/raw-body
	https://www.npmjs.com/package/raw-body
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/bytes
	dev-node/http-errors
	dev-node/iconv-lite
	dev-node/unpipe
"
