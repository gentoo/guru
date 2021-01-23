# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Configuration settings for Pelias"
HOMEPAGE="
	https://github.com/pelias/config
	https://www.npmjs.com/package/pelias-config
"
SRC_URI="https://registry.npmjs.org/pelias-config/-/pelias-config-4.12.1.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/hapi+joi
	dev-node/lodash
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
