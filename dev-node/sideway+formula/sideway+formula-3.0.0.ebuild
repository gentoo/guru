# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Math and string formula parser."
HOMEPAGE="
	https://github.com/sideway/formula
	https://www.npmjs.com/package/@sideway/formula
"
SRC_URI="https://registry.npmjs.org/@sideway/formula/-/formula-3.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/@sideway/formula"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}