# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Topological sorting with grouping support"
HOMEPAGE="
	https://github.com/hapijs/topo
	https://www.npmjs.com/package/@hapi/topo
"
SRC_URI="https://registry.npmjs.org/@hapi/topo/-/topo-5.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/hapi+hoek
"
