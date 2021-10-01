# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="find all require() calls by walking the AST"
HOMEPAGE="
	https://github.com/browserify/detective
	https://www.npmjs.com/package/detective
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/acorn-node
	dev-js/defined
	dev-js/minimist
"
