# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="WebGL Maps for Vector Tiles"
HOMEPAGE="
	https://github.com/tangrams/tangram
	https://www.npmjs.com/package/tangram
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/mapbox+vector-tile
	dev-js/csscolorparser
	dev-js/earcut
	dev-js/fontfaceobserver
	dev-js/geojson-vt
	dev-js/gl-mat3
	dev-js/gl-mat4
	dev-js/gl-shader-errors
	dev-js/js-yaml
	dev-js/jszip
	dev-js/pbf
	dev-js/topojson-client
"
