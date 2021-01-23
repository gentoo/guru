# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Take a nested Javascript object and flatten it, or unflatten an object with delimited keys"
HOMEPAGE="
	https://github.com/hughsk/flat
	https://www.npmjs.com/package/flat
"
SRC_URI="https://registry.npmjs.org/flat/-/flat-5.0.2.tgz"
LICENSE="BSD"
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