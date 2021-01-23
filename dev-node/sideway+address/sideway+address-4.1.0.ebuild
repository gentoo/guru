# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Email address and domain validation"
HOMEPAGE="
	https://github.com/sideway/address
	https://www.npmjs.com/package/@sideway/address
"
SRC_URI="https://registry.npmjs.org/@sideway/address/-/address-4.1.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/@sideway/address"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}