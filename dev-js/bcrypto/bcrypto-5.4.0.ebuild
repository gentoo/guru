# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="JS crypto library"
HOMEPAGE="
	https://github.com/bcoin-org/bcrypto
	https://www.npmjs.com/package/bcrypto
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bufio
	dev-js/loady
"
