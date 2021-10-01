# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The fastest and smallest JavaScript polygon triangulation library for your WebGL apps"
HOMEPAGE="
	https://github.com/mapbox/earcut
	https://www.npmjs.com/package/earcut
"

LICENSE="ISC"
KEYWORDS="~amd64"
BDEPEND="
	${BDEPEND}
	dev-js/browserify
"
