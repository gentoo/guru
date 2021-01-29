# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Simplest way to make http get requests. Supports HTTPS, redirects, gzip/deflate, streams in < 100 lines."
HOMEPAGE="
	https://github.com/feross/simple-get
	https://www.npmjs.com/package/simple-get
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/decompress-response
	dev-node/once
	dev-node/simple-concat
"
