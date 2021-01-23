# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="The Node.js `util.deprecate()` function with browser support"
HOMEPAGE="
	https://github.com/TooTallNate/util-deprecate
	https://www.npmjs.com/package/util-deprecate
"
SRC_URI="https://registry.npmjs.org/util-deprecate/-/util-deprecate-1.0.2.tgz"
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