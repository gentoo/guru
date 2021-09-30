# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="UPNP client for node.js"
HOMEPAGE="
	https://github.com/bcoin-org/bupnp
	https://www.npmjs.com/package/bupnp
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/binet
	dev-js/brq
	dev-js/bsert
"
