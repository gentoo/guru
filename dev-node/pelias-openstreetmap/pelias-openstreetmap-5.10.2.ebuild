# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Pelias openstreetmap utilities"
HOMEPAGE="
	https://github.com/mapzen/pelias-openstreetmap
	https://www.npmjs.com/package/pelias-openstreetmap
"
SRC_URI="https://registry.npmjs.org/pelias-openstreetmap/-/pelias-openstreetmap-5.10.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/async
	dev-node/combined-stream
	dev-node/extend
	dev-node/is-object
	dev-node/iso_639_3
	dev-node/joi
	dev-node/lodash
	dev-node/merge
	dev-node/pbf2json
	dev-node/pelias-blacklist-stream
	dev-node/pelias-config
	dev-node/pelias-dbclient
	dev-node/pelias-logger
	dev-node/pelias-model
	dev-node/pelias-wof-admin-lookup
	dev-node/through2
	dev-node/through2-sink
"
