# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Execute a callback when a request closes, finishes, or errors"
HOMEPAGE="
	https://github.com/jshttp/on-finished
	https://www.npmjs.com/package/on-finished
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ee-first
"
