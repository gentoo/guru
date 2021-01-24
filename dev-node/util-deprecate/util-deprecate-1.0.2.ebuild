# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="The Node.js util.deprecate() function with browser support"
HOMEPAGE="
	https://github.com/TooTallNate/util-deprecate
	https://www.npmjs.com/package/util-deprecate
"
SRC_URI="https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
