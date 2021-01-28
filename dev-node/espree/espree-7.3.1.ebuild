# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="An Esprima-compatible JavaScript parser built on Acorn"
HOMEPAGE="
	https://github.com/eslint/espree
	https://www.npmjs.com/package/espree
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/acorn
	dev-node/acorn-jsx
	dev-node/eslint-visitor-keys
"
