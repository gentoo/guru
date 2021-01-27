# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Object schema validation"
first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="https://registry.npmjs.org/@${first}/${second}/-/${second}.tgz -> ${P}.tgz"
HOMEPAGE="
	https://github.com/hapijs/joi
	https://www.npmjs.com/package/@hapi/joi
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/hapi+address
	dev-node/hapi+formula
	dev-node/hapi+hoek
	dev-node/hapi+pinpoint
	dev-node/hapi+topo
"