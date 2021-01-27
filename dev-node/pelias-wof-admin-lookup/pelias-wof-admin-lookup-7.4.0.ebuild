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
	dev-node/hapi+joi
	dev-node/async
	dev-node/csv-parse
	dev-node/lodash
	dev-node/parallel-transform
	dev-node/pelias-config
	dev-node/pelias-logger
	dev-node/pelias-microservice-wrapper
	dev-node/pelias-whosonfirst
	dev-node/polygon-lookup
	dev-node/request
	dev-node/simplify-js
	dev-node/stable
	dev-node/through2
	dev-node/through2-filter
	dev-node/through2-map
	dev-node/through2-sink
"
