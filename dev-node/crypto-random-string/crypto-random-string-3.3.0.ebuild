# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Generate a cryptographically strong random string"
HOMEPAGE="
	https://github.com/sindresorhus/crypto-random-string
	https://www.npmjs.com/package/crypto-random-string
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/type-fest
"
