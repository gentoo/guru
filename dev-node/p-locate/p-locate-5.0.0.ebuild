# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the first fulfilled promise that satisfies the provided testing function"
HOMEPAGE="
	https://github.com/sindresorhus/p-locate
	https://www.npmjs.com/package/p-locate
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/p-limit
"