# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get metadata of a package from the npm registry"
HOMEPAGE="
	https://github.com/sindresorhus/package-json
	https://www.npmjs.com/package/package-json
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/got
	dev-node/registry-auth-token
	dev-node/registry-url
	dev-node/semver
"
