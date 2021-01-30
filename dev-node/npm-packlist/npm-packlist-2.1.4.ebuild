# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Get a list of the files to add from a folder into an npm package"
HOMEPAGE="
	https://github.com/npm/npm-packlist
	https://www.npmjs.com/package/npm-packlist
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/glob
	dev-node/ignore-walk
	dev-node/npm-bundled
	dev-node/npm-normalize-package-bin
"
