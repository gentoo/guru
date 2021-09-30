# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Web bike-shed"
HOMEPAGE="
	https://github.com/bcoin-org/bweb
	https://www.npmjs.com/package/bweb
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
	dev-js/bsock
"
