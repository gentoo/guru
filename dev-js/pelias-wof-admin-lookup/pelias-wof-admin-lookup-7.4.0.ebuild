# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A fast, local, streaming Who's On First administrative hierarchy lookup."
HOMEPAGE="
	https://github.com/pelias/wof-admin-lookup
	https://www.npmjs.com/package/pelias-wof-admin-lookup
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hapi+joi
	dev-js/async
	dev-js/csv-parse
	dev-js/lodash
	dev-js/parallel-transform
	dev-js/pelias-config
	dev-js/pelias-logger
	dev-js/pelias-microservice-wrapper
	dev-js/pelias-whosonfirst
	dev-js/polygon-lookup
	dev-js/request
	dev-js/simplify-js
	dev-js/stable
	dev-js/through2
	dev-js/through2-filter
	dev-js/through2-map
	dev-js/through2-sink
"
