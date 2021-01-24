# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A tiny and fast selection algorithm in JavaScript."
HOMEPAGE="
	https://www.npmjs.com/package/quickselect
"
SRC_URI="https://registry.npmjs.org/quickselect/-/quickselect-${PV}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
