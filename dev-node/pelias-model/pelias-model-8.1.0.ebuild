# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Pelias data models"
HOMEPAGE="
	https://github.com/pelias/model
	https://www.npmjs.com/package/pelias-model
"
SRC_URI="https://registry.npmjs.org/pelias-model/-/pelias-model-8.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/lodash
	dev-node/pelias-config
	dev-node/through2
"
