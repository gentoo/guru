# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="yargs the modern, pirate-themed, successor to optimist."
HOMEPAGE="
	https://yargs.js.org/
	https://www.npmjs.com/package/yargs
"
SRC_URI="https://registry.npmjs.org/yargs/-/yargs-16.2.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/cliui
	dev-node/escalade
	dev-node/get-caller-file
	dev-node/require-directory
	dev-node/string-width
	dev-node/y18n
	dev-node/yargs-parser
"
