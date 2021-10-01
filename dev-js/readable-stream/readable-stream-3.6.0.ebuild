# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Streams3, a user-land copy of the stream library from Node.js"
HOMEPAGE="
	https://github.com/nodejs/readable-stream
	https://www.npmjs.com/package/readable-stream
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/string_decoder
	dev-js/util-deprecate
"
