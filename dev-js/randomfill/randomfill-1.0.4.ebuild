# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="random fill from browserify stand alone"
HOMEPAGE="
	https://github.com/crypto-browserify/randomfill
	https://www.npmjs.com/package/randomfill
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/randombytes
	dev-js/safe-buffer
"
