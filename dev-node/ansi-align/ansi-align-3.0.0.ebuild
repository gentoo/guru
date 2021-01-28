# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="align-text with ANSI support for CLIs"
HOMEPAGE="
	https://github.com/nexdrew/ansi-align
	https://www.npmjs.com/package/ansi-align
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/string-width
"
