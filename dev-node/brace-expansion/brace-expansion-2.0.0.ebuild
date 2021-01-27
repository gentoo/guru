# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Brace expansion as known from sh/bash"
HOMEPAGE="
	https://github.com/juliangruber/brace-expansion
	https://www.npmjs.com/package/brace-expansion
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/balanced-match
"