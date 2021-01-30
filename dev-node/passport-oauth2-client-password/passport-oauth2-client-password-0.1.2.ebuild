# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="OAuth 2.0 client password authentication strategy for Passport."
HOMEPAGE="
	https://github.com/jaredhanson/passport-oauth2-client-password
	https://www.npmjs.com/package/passport-oauth2-client-password
"
KEYWORDS="~amd64"
LICENSE="MIT"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/passport-strategy
"
