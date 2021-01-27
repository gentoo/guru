# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="yargs the modern, pirate-themed, successor to optimist."
HOMEPAGE="
	https://yargs.js.org/
	https://www.npmjs.com/package/yargs
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cliui
	dev-node/escalade
	dev-node/get-caller-file
	dev-node/require-directory
	dev-node/string-width
	dev-node/y18n
	dev-node/yargs-parser
"
