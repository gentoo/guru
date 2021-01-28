# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Automatically cleanup expired items in a Map"
HOMEPAGE="
	https://github.com/SamVerschueren/map-age-cleaner
	https://www.npmjs.com/package/map-age-cleaner
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/p-defer
"
