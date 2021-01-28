# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Native DTrace providers for node.js applications"
HOMEPAGE="
	https://github.com/chrisa/node-dtrace-provider
	https://www.npmjs.com/package/dtrace-provider
"

LICENSE="BSD-2"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/nan
"
