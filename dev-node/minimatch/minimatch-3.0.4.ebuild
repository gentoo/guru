# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="a glob matcher in javascript"
HOMEPAGE="
	https://github.com/isaacs/minimatch
	https://www.npmjs.com/package/minimatch
"
SRC_URI="https://registry.npmjs.org/minimatch/-/minimatch-3.0.4.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/brace-expansion
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}