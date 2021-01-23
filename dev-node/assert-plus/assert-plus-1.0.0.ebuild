# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Extra assertions on top of node's assert module"
HOMEPAGE="
	https://github.com/mcavage/node-assert-plus
	https://www.npmjs.com/package/assert-plus
"
SRC_URI="https://registry.npmjs.org/assert-plus/-/assert-plus-1.0.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/assert-plus"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}