# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="JSON Web Token implementation (symmetric and asymmetric)"
HOMEPAGE="
	https://github.com/auth0/node-jsonwebtoken
	https://www.npmjs.com/package/jsonwebtoken
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/jws
	dev-node/lodash_includes
	dev-node/lodash_isboolean
	dev-node/lodash_isinteger
	dev-node/lodash_isnumber
	dev-node/lodash_isplainobject
	dev-node/lodash_isstring
	dev-node/lodash_once
	dev-node/ms
	dev-node/semver
"
