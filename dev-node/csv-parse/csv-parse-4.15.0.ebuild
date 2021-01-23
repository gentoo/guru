# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="CSV parsing implementing the Node.js stream.Transform API"
HOMEPAGE="
	https://csv.js.org/parse/
	https://www.npmjs.com/package/csv-parse
"
SRC_URI="https://registry.npmjs.org/csv-parse/-/csv-parse-4.15.0.tgz"
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
