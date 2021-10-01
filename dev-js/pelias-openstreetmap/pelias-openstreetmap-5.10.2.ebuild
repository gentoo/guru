# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Pelias openstreetmap utilities"
HOMEPAGE="
	https://github.com/mapzen/pelias-openstreetmap
	https://www.npmjs.com/package/pelias-openstreetmap
"

LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/async
	dev-js/combined-stream
	dev-js/extend
	dev-js/is-object
	dev-js/iso_639_3
	dev-js/joi
	dev-js/lodash
	dev-js/merge
	dev-js/pbf2json
	dev-js/pelias-blacklist-stream
	dev-js/pelias-config
	dev-js/pelias-dbclient
	dev-js/pelias-logger
	dev-js/pelias-model
	dev-js/pelias-wof-admin-lookup
	dev-js/through2
	dev-js/through2-sink
"
