# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node
MYPN="acorn"
DESCRIPTION="ECMAScript (ESTree) AST walker"
HOMEPAGE="https://github.com/acornjs/acorn https://www.npmjs.com/package/acorn-walk"
SRC_URI="https://github.com/acornjs/acorn/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}/${PN}"
LICENSE="MIT"
KEYWORDS="~amd64"
