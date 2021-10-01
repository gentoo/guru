# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Convert milliseconds to a human readable string"
HOMEPAGE="
	https://github.com/sindresorhus/pretty-ms
	https://www.npmjs.com/package/pretty-ms
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/parse-ms
"
