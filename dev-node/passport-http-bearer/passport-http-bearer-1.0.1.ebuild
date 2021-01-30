# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="HTTP Bearer authentication strategy for Passport."
HOMEPAGE="
		https://www.npmjs.com/package/passport-http-bearer
"
KEYWORDS="~amd64"
LICENSE="MIT"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/passport-strategy
"
