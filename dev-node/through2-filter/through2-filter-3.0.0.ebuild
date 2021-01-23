# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A through2 to create an Array.prototype.filter analog for streams."
HOMEPAGE="
	https://github.com/brycebaril/through2-filter
	https://www.npmjs.com/package/through2-filter
"
SRC_URI="https://registry.npmjs.org/through2-filter/-/through2-filter-3.0.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/through2
	dev-node/xtend
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}