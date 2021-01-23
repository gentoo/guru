# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="process.stdout in your browser"
HOMEPAGE="
	https://github.com/kumavis/browser-stdout
	https://www.npmjs.com/package/browser-stdout
"
SRC_URI="https://registry.npmjs.org/browser-stdout/-/browser-stdout-1.3.1.tgz"
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

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
