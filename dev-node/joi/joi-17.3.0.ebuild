# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Object schema validation"
HOMEPAGE="
	https://github.com/sideway/joi
	https://www.npmjs.com/package/joi
"
SRC_URI="https://registry.npmjs.org/joi/-/joi-17.3.0.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+hoek
	dev-node/hapi+topo
	dev-node/sideway+address
	dev-node/sideway+formula
	dev-node/sideway+pinpoint
"
