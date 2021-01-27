# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Convert milliseconds to a human readable string: 1337000000 → 15d 11h 23m 20s"
HOMEPAGE="
	https://github.com/sindresorhus/pretty-ms
	https://www.npmjs.com/package/pretty-ms
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/parse-ms
"
