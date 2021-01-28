# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the visual width of the widest line in a string - the number of columns required to display it"
HOMEPAGE="
	https://github.com/sindresorhus/widest-line
	https://www.npmjs.com/package/widest-line
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/string-width
"
