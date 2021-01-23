# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="The fastest and simplest library for SQLite3 in Node.js."
HOMEPAGE="
	https://github.com/JoshuaWise/better-sqlite3
	https://www.npmjs.com/package/better-sqlite3
"
SRC_URI="https://registry.npmjs.org/better-sqlite3/-/better-sqlite3-7.1.2.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/bindings
	dev-node/prebuild-install
	dev-node/tar
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
