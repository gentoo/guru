# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Importer for Who's on First"
HOMEPAGE="
	https://github.com/pelias/whosonfirst
	https://www.npmjs.com/package/pelias-whosonfirst
"
SRC_URI="https://registry.npmjs.org/pelias-whosonfirst/-/pelias-whosonfirst-5.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+joi
	dev-node/async
	dev-node/better-sqlite3
	dev-node/combined-stream
	dev-node/command-exists
	dev-node/download-file-sync
	dev-node/iso3166_1
	dev-node/lodash
	dev-node/pelias-blacklist-stream
	dev-node/pelias-config
	dev-node/pelias-dbclient
	dev-node/pelias-logger
	dev-node/pelias-model
	dev-node/through2
	dev-node/through2-filter
	dev-node/through2-map
	dev-node/through2-sink
"
