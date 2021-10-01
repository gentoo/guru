# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Object schema validation"
first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="mirror://npm/@${first}/${second}/-/${second}-${PV}.tgz -> ${P}.tgz"
HOMEPAGE="
	https://github.com/hapijs/joi
	https://www.npmjs.com/package/@hapi/joi
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hapi+address
	dev-js/hapi+formula
	dev-js/hapi+hoek
	dev-js/hapi+pinpoint
	dev-js/hapi+topo
"
