# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Prepare a node environment to require files with different extensions."
HOMEPAGE="
	https://github.com/gulpjs/rechoir
	https://www.npmjs.com/package/rechoir
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/resolve
"
