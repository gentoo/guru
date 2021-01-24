# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="a glob matcher in javascript"
HOMEPAGE="
	https://github.com/isaacs/minimatch
	https://www.npmjs.com/package/minimatch
"
SRC_URI="https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/brace-expansion
"
