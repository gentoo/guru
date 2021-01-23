# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Helper module for loading your native module's .node file"
HOMEPAGE="
	https://github.com/TooTallNate/node-bindings
	https://www.npmjs.com/package/bindings
"
SRC_URI="https://registry.npmjs.org/bindings/-/bindings-1.5.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/bindings"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}