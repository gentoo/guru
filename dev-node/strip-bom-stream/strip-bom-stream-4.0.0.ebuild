# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Strip UTF-8 byte order mark (BOM) from a stream"
HOMEPAGE="
	https://github.com/sindresorhus/strip-bom-stream
	https://www.npmjs.com/package/strip-bom-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/first-chunk-stream
	dev-node/strip-bom-buf
"
