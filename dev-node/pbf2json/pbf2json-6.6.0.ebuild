# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Golang osm pbf parser with npm wrapper"
HOMEPAGE="
	https://github.com/pelias/pbf2json
	https://www.npmjs.com/package/pbf2json
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/split
	dev-node/through2
"