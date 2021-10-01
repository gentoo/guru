# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="DES implementation"
HOMEPAGE="
	https://github.com/indutny/des.js
	https://www.npmjs.com/package/des.js
"

MYPN="${PN//_/.}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/inherits
	dev-js/minimalistic-assert
"
