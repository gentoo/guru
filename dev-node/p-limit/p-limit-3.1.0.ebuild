# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Run multiple promise-returning & async functions with limited concurrency"
HOMEPAGE="
	https://github.com/sindresorhus/p-limit
	https://www.npmjs.com/package/p-limit
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/yocto-queue
"