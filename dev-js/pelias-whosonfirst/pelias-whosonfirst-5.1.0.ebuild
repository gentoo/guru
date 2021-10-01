# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Importer for Who's on First"
HOMEPAGE="
	https://github.com/pelias/whosonfirst
	https://www.npmjs.com/package/pelias-whosonfirst
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hapi+joi
	dev-js/async
	dev-js/better-sqlite3
	dev-js/combined-stream
	dev-js/command-exists
	dev-js/download-file-sync
	dev-js/iso3166_1
	dev-js/lodash
	dev-js/pelias-blacklist-stream
	dev-js/pelias-config
	dev-js/pelias-dbclient
	dev-js/pelias-logger
	dev-js/pelias-model
	dev-js/through2
	dev-js/through2-filter
	dev-js/through2-map
	dev-js/through2-sink
"
