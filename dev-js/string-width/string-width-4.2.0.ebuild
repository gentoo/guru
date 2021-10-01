# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the visual width of a string - the number of columns required to display it"
HOMEPAGE="
	https://github.com/sindresorhus/string-width
	https://www.npmjs.com/package/string-width
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/emoji-regex
	dev-js/is-fullwidth-code-point
	dev-js/strip-ansi
"
