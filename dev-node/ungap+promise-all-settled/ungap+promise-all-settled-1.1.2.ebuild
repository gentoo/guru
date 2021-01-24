# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A cross platform Promise.allSettled polyfill"
HOMEPAGE="
	https://github.com/ungap/promise-all-settled
	https://www.npmjs.com/package/@ungap/promise-all-settled
"
SRC_URI="https://registry.npmjs.org/@ungap/promise-all-settled/-/promise-all-settled-1.1.2.tgz -> ${P}.tgz"
LICENSE="ISC"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/@ungap/promise-all-settled"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}