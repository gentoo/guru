# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Caseless object set/get/has, very useful when working with HTTP headers."
HOMEPAGE="
	https://github.com/mikeal/caseless
	https://www.npmjs.com/package/caseless
"
SRC_URI="https://registry.npmjs.org/caseless/-/caseless-0.12.0.tgz"
LICENSE="Apache-2.0"
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