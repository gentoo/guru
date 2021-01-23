# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Like which(1) unix command. Find the first instance of an executable in the PATH."
HOMEPAGE="
	https://github.com/isaacs/node-which
	https://www.npmjs.com/package/which
"
SRC_URI="https://registry.npmjs.org/which/-/which-2.0.2.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/isexe
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}