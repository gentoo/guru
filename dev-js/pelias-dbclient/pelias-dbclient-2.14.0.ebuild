# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Database client for Pelias import pipelines"
HOMEPAGE="
	https://github.com/pelias/dbclient
	https://www.npmjs.com/package/pelias-dbclient
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hapi+joi
	dev-js/elasticsearch
	dev-js/pelias-config
	dev-js/pelias-logger
	dev-js/through2
"
