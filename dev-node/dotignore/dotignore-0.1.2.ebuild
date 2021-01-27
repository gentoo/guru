# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ignorefile/includefile matching .gitignore spec"
HOMEPAGE="
	https://github.com/bmeck/dotignore
	https://www.npmjs.com/package/dotignore
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/minimatch
"
