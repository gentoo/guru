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
		dev-js/colors
		dev-js/deep-diff
		dev-js/istanbul
		dev-js/jshint
		dev-js/naivedb
		dev-js/pelias-mock-logger
		dev-js/precommit-hook
		dev-js/proxyquire
		dev-js/stream-mock
		dev-js/taginfo
		dev-js/tap-spec
		dev-js/tape
	)
"
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
