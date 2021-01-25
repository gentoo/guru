# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Configuration settings for Pelias"
HOMEPAGE="
	https://github.com/pelias/config
	https://www.npmjs.com/package/pelias-config
"
SRC_URI="https://registry.npmjs.org/pelias-config/-/pelias-config-4.12.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+joi
	dev-node/lodash
"
