# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="General purpose node utilities"
HOMEPAGE="
	https://github.com/hapijs/hoek
	https://www.npmjs.com/package/@hapi/hoek
"
SRC_URI="https://registry.npmjs.org/@hapi/hoek/-/hoek-9.1.1.tgz -> ${P}.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-misc/jq
	sys-apps/moreutils
"
S="${WORKDIR}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/@hapi/hoek"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}