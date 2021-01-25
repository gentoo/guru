# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Extract names from functions"
HOMEPAGE="
	https://github.com/3rd-Eden/fn.name
	https://www.npmjs.com/package/fn.name
"
SRC_URI="https://registry.npmjs.org/fn.name/-/fn.name-1.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
MYPN="${PN/_/.}"
