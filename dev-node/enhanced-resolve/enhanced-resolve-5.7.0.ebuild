# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Offers a async require.resolve function. It's highly configurable."
HOMEPAGE="
	https://github.com/webpack/enhanced-resolve
	https://www.npmjs.com/package/enhanced-resolve
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/graceful-fs
	dev-node/tapable
"
