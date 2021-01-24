# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Object schema validation"
HOMEPAGE="
	https://github.com/sideway/joi
	https://www.npmjs.com/package/joi
"
SRC_URI="https://registry.npmjs.org/joi/-/joi-17.3.0.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/hapi+hoek
	dev-node/hapi+topo
	dev-node/sideway+address
	dev-node/sideway+formula
	dev-node/sideway+pinpoint
"
BDEPEND="
	app-misc/jq
	sys-apps/moreutils
"
S="${WORKDIR}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
