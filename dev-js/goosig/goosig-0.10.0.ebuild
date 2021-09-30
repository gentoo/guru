# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Group of unknown order signatures"
HOMEPAGE="
	https://github.com/handshake-org/goosig
	https://www.npmjs.com/package/goosig
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bcrypto
	dev-js/bsert
	dev-js/loady
"
