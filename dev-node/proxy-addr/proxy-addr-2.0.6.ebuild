# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Determine address of proxied request"
HOMEPAGE="
	https://github.com/jshttp/proxy-addr
	https://www.npmjs.com/package/proxy-addr
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/forwarded
	dev-node/ipaddr_js
"
