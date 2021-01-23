# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Fast point-in-polygon intersection for large numbers of polygons."
HOMEPAGE="
	https://github.com/pelias/polygon-lookup
	https://www.npmjs.com/package/polygon-lookup
"
SRC_URI="https://registry.npmjs.org/polygon-lookup/-/polygon-lookup-2.6.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/lodash
	dev-node/point-in-polygon
	dev-node/rbush
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}