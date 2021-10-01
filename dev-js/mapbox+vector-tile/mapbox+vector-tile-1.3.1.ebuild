# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Parses vector tiles"
HOMEPAGE="
	https://github.com/mapbox/vector-tile-js
	https://www.npmjs.com/package/@mapbox/vector-tile
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/mapbox+point-geometry
"
