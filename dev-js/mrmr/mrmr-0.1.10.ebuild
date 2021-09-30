# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Murmur3 for javascript"
HOMEPAGE="
	https://github.com/bcoin-org/mrmr
	https://www.npmjs.com/package/mrmr
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bsert
	dev-js/loady
"
