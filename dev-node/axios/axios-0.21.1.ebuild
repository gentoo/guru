# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Promise based HTTP client for the browser and node.js"
HOMEPAGE="
	https://github.com/axios/axios
	https://www.npmjs.com/package/axios
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/follow-redirects
"
