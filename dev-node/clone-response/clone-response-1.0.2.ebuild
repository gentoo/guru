# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Clone a Node.js HTTP response stream"
HOMEPAGE="
	https://github.com/lukechilds/clone-response
	https://www.npmjs.com/package/clone-response
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mimic-response
"
