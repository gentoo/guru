# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Object schema validation"
HOMEPAGE="
	https://github.com/hapijs/joi
	https://www.npmjs.com/package/@hapi/joi
"
SRC_URI="https://registry.npmjs.org/@hapi/joi/-/joi-17.1.1.tgz -> ${P}.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/hapi+address
	dev-node/hapi+formula
	dev-node/hapi+hoek
	dev-node/hapi+pinpoint
	dev-node/hapi+topo
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/@hapi/joi"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}