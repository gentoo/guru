# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Cryptographically provable database"
HOMEPAGE="
	https://github.com/handshake-org/urkel
	https://www.npmjs.com/package/urkel
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bfile
	dev-js/bmutex
	dev-js/bsert
"
