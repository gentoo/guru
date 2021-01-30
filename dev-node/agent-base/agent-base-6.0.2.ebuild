# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Turn a function into an http.Agent instance"
HOMEPAGE="
	https://github.com/TooTallNate/node-agent-base
	https://www.npmjs.com/package/agent-base
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
"
