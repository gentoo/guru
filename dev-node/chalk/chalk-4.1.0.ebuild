# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Terminal string styling done right"
HOMEPAGE="
	https://github.com/chalk/chalk
	https://www.npmjs.com/package/chalk
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ansi-styles
"