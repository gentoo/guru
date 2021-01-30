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
IUSE="test"
#no tests in tarball
RESTRICT="test"

BDEPEND="
	${NODEJS_BDEPEND}
	test? (
		dev-node/colors
		dev-node/deep-diff
		dev-node/istanbul
		dev-node/jshint
		dev-node/naivedb
		dev-node/pelias-mock-logger
		dev-node/precommit-hook
		dev-node/proxyquire
		dev-node/stream-mock
		dev-node/taginfo
		dev-node/tap-spec
		dev-node/tape
	)
"
RDEPEND="
	${NODEJS_RDEPEND}
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
