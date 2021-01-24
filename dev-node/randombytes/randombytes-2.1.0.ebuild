# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="random bytes from browserify stand alone"
HOMEPAGE="
	https://github.com/crypto-browserify/randombytes
	https://www.npmjs.com/package/randombytes
"
SRC_URI="https://registry.npmjs.org/randombytes/-/randombytes-2.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/safe-buffer
"
