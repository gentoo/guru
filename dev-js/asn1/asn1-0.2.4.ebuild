# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Contains parsers and serializers for ASN.1 (currently BER only)"
HOMEPAGE="
	https://github.com/joyent/node-asn1
	https://www.npmjs.com/package/asn1
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/safer-buffer
"
