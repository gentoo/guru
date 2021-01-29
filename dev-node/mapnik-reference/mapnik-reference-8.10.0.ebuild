# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Reference for Mapnik Styling Options"
HOMEPAGE="
	https://github.com/mapnik/mapnik-reference
	https://www.npmjs.com/package/mapnik-reference
"
KEYWORDS="~amd64"
LICENSE="Unlicense"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/lodash
	dev-node/semver
"
