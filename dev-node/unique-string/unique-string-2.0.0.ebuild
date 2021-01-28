# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Generate a unique random string"
HOMEPAGE="
	https://github.com/sindresorhus/unique-string
	https://www.npmjs.com/package/unique-string
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/crypto-random-string
"
