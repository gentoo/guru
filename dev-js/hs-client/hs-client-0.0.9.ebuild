# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="HSD node and wallet client"
HOMEPAGE="
	https://github.com/handshake-org/hs-client
	https://www.npmjs.com/package/hs-client
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bcfg
	dev-js/bcurl
	dev-js/bsert
"
