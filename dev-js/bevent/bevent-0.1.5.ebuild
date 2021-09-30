# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Async event emitter for javascript"
HOMEPAGE="
	https://github.com/bcoin-org/bevent
	https://www.npmjs.com/package/bevent
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
"
