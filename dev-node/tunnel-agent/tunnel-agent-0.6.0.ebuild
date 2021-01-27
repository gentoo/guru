# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="HTTP proxy tunneling agent. Formerly part of mikeal/request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/tunnel-agent
	https://www.npmjs.com/package/tunnel-agent
"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/safe-buffer
"