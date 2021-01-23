# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A wide-character aware text alignment function for use on the console or with fixed width fonts."
HOMEPAGE="
	https://github.com/iarna/wide-align
	https://www.npmjs.com/package/wide-align
"
SRC_URI="https://registry.npmjs.org/wide-align/-/wide-align-1.1.3.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/string-width
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}