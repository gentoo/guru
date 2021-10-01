# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Manipulate TopoJSON and convert it to GeoJSON."
HOMEPAGE="
	https://github.com/topojson/topojson-client
	https://www.npmjs.com/package/topojson-client
"

LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/commander
"
