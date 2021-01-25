# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Database client for Pelias import pipelines"
HOMEPAGE="
	https://github.com/pelias/dbclient
	https://www.npmjs.com/package/pelias-dbclient
"
SRC_URI="https://registry.npmjs.org/pelias-dbclient/-/pelias-dbclient-2.14.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+joi
	dev-node/elasticsearch
	dev-node/pelias-config
	dev-node/pelias-logger
	dev-node/through2
"
