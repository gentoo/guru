# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Make a callback- or promise-based function support both promises and callbacks."
HOMEPAGE="
	https://github.com/RyanZim/universalify
	https://www.npmjs.com/package/universalify
"
SRC_URI="https://registry.npmjs.org/universalify/-/universalify-2.0.0.tgz"
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