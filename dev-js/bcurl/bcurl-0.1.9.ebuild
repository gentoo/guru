# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Web client bike-shed"
HOMEPAGE="
	https://github.com/bcoin-org/bcurl
	https://www.npmjs.com/package/bcurl
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/brq
	dev-js/bsert
	dev-js/bsock
"
