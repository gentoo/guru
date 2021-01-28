# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Translate ECDSA signatures between ASN.1/DER and JOSE-style concatenation"
HOMEPAGE="
	https://github.com/Brightspace/node-ecdsa-sig-formatter
	https://www.npmjs.com/package/ecdsa-sig-formatter
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/safe-buffer
"
