# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A high-performance JavaScript 2D/3D polyline simplification library"
HOMEPAGE="
	http://mourner.github.com/simplify-js/
	https://www.npmjs.com/package/simplify-js
"
SRC_URI="https://registry.npmjs.org/simplify-js/-/simplify-js-1.2.4.tgz"
LICENSE="BSD-2"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}