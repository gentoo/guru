# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

MYPN="${PN/_/-}"
MYP="${MYPN}-${PV}"
SRC_URI="https://registry.npmjs.org/${MYPN}/-/${MYP}.tgz -> ${P}.tgz"
DESCRIPTION="Pure-JS CRC-32"
HOMEPAGE="
	http://sheetjs.com/opensource
	https://www.npmjs.com/package/crc-32
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/printj
	dev-node/exit-on-epipe
"
