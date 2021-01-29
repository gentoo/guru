# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Strip UTF-8 byte order mark (BOM) from a buffer"
HOMEPAGE="
	https://github.com/sindresorhus/strip-bom-buf
	https://www.npmjs.com/package/strip-bom-buf
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-utf8
"
