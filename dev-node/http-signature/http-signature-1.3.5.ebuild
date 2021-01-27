# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Reference implementation of Joyent's HTTP Signature scheme."
HOMEPAGE="
	https://github.com/joyent/node-http-signature/
	https://www.npmjs.com/package/http-signature
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/assert-plus
	dev-node/jsprim
	dev-node/sshpk
"