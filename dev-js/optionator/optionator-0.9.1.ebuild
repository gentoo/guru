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
	dev-js/prelude-ls
	dev-js/deep-is
	dev-js/word-wrap
	dev-js/type-check
	dev-js/levn
	dev-js/fast-levenshtein
"
