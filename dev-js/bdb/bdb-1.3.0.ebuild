# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Database for bcoin"
HOMEPAGE="
	https://github.com/bcoin-org/bdb
	https://www.npmjs.com/package/bdb
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
	dev-js/loady
"
