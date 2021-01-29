# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Mapnik Stylesheet Compiler"
HOMEPAGE="
	https://github.com/mapbox/carto
	https://www.npmjs.com/package/carto
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/chroma-js
	dev-node/hsluv
	dev-node/js-yaml
	dev-node/lodash
	dev-node/mapnik-reference
	dev-node/semver
	dev-node/yargs
"
