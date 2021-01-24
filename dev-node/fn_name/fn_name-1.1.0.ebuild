# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Extract names from functions"
HOMEPAGE="
	https://github.com/3rd-Eden/fn.name
	https://www.npmjs.com/package/fn.name
"
SRC_URI="https://registry.npmjs.org/fn.name/-/fn.name-1.1.0.tgz"
LICENSE="MIT"
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
MYPN="${PN/_/.}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${MYPN}" || die
}
