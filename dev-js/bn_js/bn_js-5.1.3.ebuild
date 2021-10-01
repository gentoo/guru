# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Big number implementation in pure javascript"
HOMEPAGE="
	https://github.com/indutny/bn.js
	https://www.npmjs.com/package/bn.js
"

MYPN="${PN//_/.}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
