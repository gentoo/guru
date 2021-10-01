# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="ASN.1 encoder and decoder"
HOMEPAGE="
	https://github.com/indutny/asn1.js
	https://www.npmjs.com/package/asn1.js
"

MYPN="${PN//_/.}"
SRC_URI="mirror://npm/${MYPN}/-/${MYPN}-${PV}.tgz -> ${P}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bn_js
	dev-js/inherits
	dev-js/minimalistic-assert
	dev-js/safer-buffer
"
