# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Slice a string with ANSI escape codes"
HOMEPAGE="
	https://github.com/chalk/slice-ansi
	https://www.npmjs.com/package/slice-ansi
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ansi-styles
	dev-node/astral-regex
	dev-node/is-fullwidth-code-point
"
