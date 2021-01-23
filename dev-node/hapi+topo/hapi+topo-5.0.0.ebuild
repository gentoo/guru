# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Topological sorting with grouping support"
HOMEPAGE="
	https://github.com/hapijs/topo
	https://www.npmjs.com/package/@hapi/topo
"
SRC_URI="https://registry.npmjs.org/@hapi/topo/-/topo-5.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/hapi+hoek
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/@hapi/topo"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}