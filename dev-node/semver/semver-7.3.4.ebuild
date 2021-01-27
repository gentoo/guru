# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The semantic version parser used by npm."
HOMEPAGE="
	https://github.com/npm/node-semver
	https://www.npmjs.com/package/semver
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/lru-cache
"