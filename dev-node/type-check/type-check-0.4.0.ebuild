# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="type-check allows you to check the types of JavaScript values at runtime with a Haskell like type syntax."
HOMEPAGE="
	https://github.com/gkz/type-check
	https://www.npmjs.com/package/type-check
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/prelude-ls
"
