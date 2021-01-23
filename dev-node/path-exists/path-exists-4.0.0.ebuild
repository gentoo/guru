# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Check if a path exists"
HOMEPAGE="
	https://github.com/sindresorhus/path-exists
	https://www.npmjs.com/package/path-exists
"
SRC_URI="https://registry.npmjs.org/path-exists/-/path-exists-4.0.0.tgz"
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