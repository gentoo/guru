# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="abstract base class for hash-streams"
HOMEPAGE="
	https://github.com/crypto-browserify/hash-base
	https://www.npmjs.com/package/hash-base
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/readable-stream
	dev-js/safe-buffer
"
