# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Higher-level content negotiation"
HOMEPAGE="
	https://github.com/jshttp/accepts
	https://www.npmjs.com/package/accepts
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/mime-types
	dev-node/negotiator
"
