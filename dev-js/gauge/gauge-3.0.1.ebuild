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
	dev-js/aproba
	dev-js/color-support
	dev-js/console-control-strings
	dev-js/has-unicode
	dev-js/object-assign
	dev-js/signal-exit
	dev-js/string-width
	dev-js/strip-ansi
	dev-js/wide-align
"
