# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="a low-level, lightweight protocol buffers implementation in JavaScript"
HOMEPAGE="
	https://github.com/mapbox/pbf
	https://www.npmjs.com/package/pbf
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/ieee754
	dev-js/resolve-protobuf-schema
"
