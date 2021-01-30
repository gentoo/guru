# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Nested/recursive .gitignore/.npmignore parsing and filtering."
HOMEPAGE="
	https://github.com/isaacs/ignore-walk
	https://www.npmjs.com/package/ignore-walk
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/minimatch
"
