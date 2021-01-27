# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get the first path that exists on disk of multiple paths"
HOMEPAGE="
	https://github.com/sindresorhus/locate-path
	https://www.npmjs.com/package/locate-path
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/p-locate
"