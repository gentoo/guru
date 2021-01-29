# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A terminal based horizontal guage"
HOMEPAGE="
	https://github.com/npm/gauge
	https://www.npmjs.com/package/gauge
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/aproba
	dev-node/color-support
	dev-node/console-control-strings
	dev-node/has-unicode
	dev-node/signal-exit
	dev-node/string-width
	dev-node/strip-ansi
	dev-node/wide-align
"
