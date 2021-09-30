# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Bloom filters for javascript"
HOMEPAGE="
	https://github.com/bcoin-org/bfilter
	https://www.npmjs.com/package/bfilter
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
	dev-js/bufio
	dev-js/mrmr
"
