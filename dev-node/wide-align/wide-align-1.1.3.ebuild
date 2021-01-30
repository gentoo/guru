# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A wide-character aware text alignment function for use on the console or with fixed width fonts."
HOMEPAGE="
	https://github.com/iarna/wide-align
	https://www.npmjs.com/package/wide-align
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/string-width
"
