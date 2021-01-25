# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="The semantic version parser used by npm."
HOMEPAGE="
	https://github.com/npm/node-semver
	https://www.npmjs.com/package/semver
"
SRC_URI="https://registry.npmjs.org/semver/-/semver-7.3.4.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/lru-cache
"
