# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Brace expansion as known from sh/bash"
HOMEPAGE="
	https://github.com/juliangruber/brace-expansion
	https://www.npmjs.com/package/brace-expansion
"
SRC_URI="https://registry.npmjs.org/brace-expansion/-/brace-expansion-2.0.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/balanced-match
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}