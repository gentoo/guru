# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="utilities for primitive JavaScript types"
HOMEPAGE="
	https://github.com/joyent/node-jsprim
	https://www.npmjs.com/package/jsprim
"
SRC_URI="https://registry.npmjs.org/jsprim/-/jsprim-2.0.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/jsprim"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}