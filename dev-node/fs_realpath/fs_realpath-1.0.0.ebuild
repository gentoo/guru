# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Use node's fs.realpath, but fall back to the JS implementation if the native one fails"
HOMEPAGE="
	https://github.com/isaacs/fs.realpath
	https://www.npmjs.com/package/fs.realpath
"
SRC_URI="https://registry.npmjs.org/fs.realpath/-/fs.realpath-1.0.0.tgz"
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

MYPN="${PN/_/.}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${MYPN}" || die
}
