# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A tool for rapidly building command line apps"
HOMEPAGE="
	https://github.com/node-js-libs/cli
	https://www.npmjs.com/package/cli
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
	dev-node/exit
"
