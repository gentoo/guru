# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A cache object that deletes the least-recently-used items."
HOMEPAGE="
	https://github.com/isaacs/node-lru-cache
	https://www.npmjs.com/package/lru-cache
"
SRC_URI="https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/yallist
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}