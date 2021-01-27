# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="option parsing and help generation"
HOMEPAGE="
	https://github.com/gkz/optionator
	https://www.npmjs.com/package/optionator
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/prelude-ls
	dev-node/deep-is
	dev-node/word-wrap
	dev-node/type-check
	dev-node/levn
	dev-node/fast-levenshtein
"
