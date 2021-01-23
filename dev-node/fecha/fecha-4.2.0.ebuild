# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Date formatting and parsing"
HOMEPAGE="
	https://github.com/taylorhakes/fecha
	https://www.npmjs.com/package/fecha
"
SRC_URI="https://registry.npmjs.org/fecha/-/fecha-4.2.0.tgz"
LICENSE="MIT"
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