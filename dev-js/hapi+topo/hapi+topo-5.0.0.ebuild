# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Topological sorting with grouping support"
first="${PN%%+*}"
second="${PN#*+}"
SRC_URI="mirror://npm/@${first}/${second}/-/${second}-${PV}.tgz -> ${P}.tgz"
HOMEPAGE="
	https://github.com/hapijs/topo
	https://www.npmjs.com/package/@hapi/topo
"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/hapi+hoek
"
