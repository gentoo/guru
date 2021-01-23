# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Matches strings against configurable strings, globs, regular expressions, and/or functions"
HOMEPAGE="
	https://github.com/micromatch/anymatch
	https://www.npmjs.com/package/anymatch
"
SRC_URI="https://registry.npmjs.org/anymatch/-/anymatch-3.1.1.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/normalize-path
	dev-node/picomatch
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}