# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Light ECMAScript (JavaScript) Value Notation - human written, concise, typed, flexible"
HOMEPAGE="
	https://github.com/gkz/levn
	https://www.npmjs.com/package/levn
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/prelude-ls
	dev-node/type-check
"
