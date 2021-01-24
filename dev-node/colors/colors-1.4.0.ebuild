# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="get colors in your node.js console"
HOMEPAGE="
	https://github.com/Marak/colors.js
	https://www.npmjs.com/package/colors
"
SRC_URI="https://registry.npmjs.org/colors/-/colors-1.4.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
