# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="An HTTP(s) proxy http.Agent implementation for HTTPS"
HOMEPAGE="
	https://github.com/TooTallNate/node-https-proxy-agent
	https://www.npmjs.com/package/https-proxy-agent
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/agent-base
	dev-node/debug
"
