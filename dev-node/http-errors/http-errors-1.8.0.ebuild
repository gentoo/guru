# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Create HTTP error objects"
HOMEPAGE="
	https://github.com/jshttp/http-errors
	https://www.npmjs.com/package/http-errors
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/depd
	dev-node/inherits
	dev-node/setprototypeof
	dev-node/statuses
	dev-node/toidentifier
"
