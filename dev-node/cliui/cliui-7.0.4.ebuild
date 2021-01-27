# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="easily create complex multi-column command-line-interfaces"
HOMEPAGE="
	https://github.com/yargs/cliui
	https://www.npmjs.com/package/cliui
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/string-width
	dev-node/strip-ansi
	dev-node/wrap-ansi
"