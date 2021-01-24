# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A querystring parser that supports nesting and arrays, with a depth limit"
HOMEPAGE="
	https://github.com/ljharb/qs
	https://www.npmjs.com/package/qs
"
SRC_URI="https://registry.npmjs.org/qs/-/qs-6.9.6.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
