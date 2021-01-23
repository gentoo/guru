# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Browser-friendly inheritance fully compatible with standard node.js inherits()"
HOMEPAGE="
	https://github.com/isaacs/inherits
	https://www.npmjs.com/package/inherits
"
SRC_URI="https://registry.npmjs.org/inherits/-/inherits-2.0.4.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}