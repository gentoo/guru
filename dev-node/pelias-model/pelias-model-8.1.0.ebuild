# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Pelias data models"
HOMEPAGE="
	https://github.com/pelias/model
	https://www.npmjs.com/package/pelias-model
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/lodash
	dev-node/pelias-config
	dev-node/through2
"
