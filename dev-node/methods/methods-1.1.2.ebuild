# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="HTTP methods that node supports"
HOMEPAGE="
	https://github.com/jshttp/methods
	https://www.npmjs.com/package/methods
"
SRC_URI="https://registry.npmjs.org/methods/-/methods-1.1.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
