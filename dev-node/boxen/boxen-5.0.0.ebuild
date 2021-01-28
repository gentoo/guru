# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Create boxes in the terminal"
HOMEPAGE="
	https://github.com/sindresorhus/boxen
	https://www.npmjs.com/package/boxen
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ansi-align
	dev-node/camelcase
	dev-node/chalk
	dev-node/cli-boxes
	dev-node/string-width
	dev-node/type-fest
	dev-node/widest-line
	dev-node/wrap-ansi
"
