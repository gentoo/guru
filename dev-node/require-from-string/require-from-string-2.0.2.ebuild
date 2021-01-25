# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Require module from string"
HOMEPAGE="
	https://github.com/floatdrop/require-from-string
	https://www.npmjs.com/package/require-from-string
"
SRC_URI="https://registry.npmjs.org/require-from-string/-/require-from-string-2.0.2.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
