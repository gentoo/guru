# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Extract the non-magic parent path from a glob string."
HOMEPAGE="
	https://github.com/gulpjs/glob-parent
	https://www.npmjs.com/package/glob-parent
"
SRC_URI="https://registry.npmjs.org/glob-parent/-/glob-parent-5.1.1.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/is-glob
"
