# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPV="${PV/_alpha/-alpha.}"
MYP="${PN}-${MYPV}"
SRC_URI="https://registry.npmjs.org/${PN}/-/${MYP}.tgz"
DESCRIPTION="toSource converts JavaScript objects back to source"
HOMEPAGE="
	https://github.com/marcello3d/node-tosource
	https://www.npmjs.com/package/tosource
"
KEYWORDS="~amd64"
LICENSE="ZLIB"
