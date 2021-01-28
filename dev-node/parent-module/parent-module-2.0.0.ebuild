# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the path of the parent module"
HOMEPAGE="
	https://github.com/sindresorhus/parent-module
	https://www.npmjs.com/package/parent-module
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/callsites
"
