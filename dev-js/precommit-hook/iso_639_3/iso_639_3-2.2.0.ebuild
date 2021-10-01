# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPN="${PN//_/-}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"
DESCRIPTION="ISO-639-3 codes in an accessible format"
HOMEPAGE="
	https://github.com/wooorm/iso-639-3
	https://www.npmjs.com/package/iso-639-3
"
LICENSE="MIT"
KEYWORDS="~amd64"