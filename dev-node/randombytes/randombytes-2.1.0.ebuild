# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="random bytes from browserify stand alone"
HOMEPAGE="
	https://github.com/crypto-browserify/randombytes
	https://www.npmjs.com/package/randombytes
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/safe-buffer
"