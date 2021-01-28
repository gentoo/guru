# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Decompress a HTTP response if needed"
HOMEPAGE="
	https://github.com/sindresorhus/decompress-response
	https://www.npmjs.com/package/decompress-response
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mimic-response
"
