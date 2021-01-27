# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Extract the non-magic parent path from a glob string."
HOMEPAGE="
	https://github.com/gulpjs/glob-parent
	https://www.npmjs.com/package/glob-parent
"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/is-glob
"