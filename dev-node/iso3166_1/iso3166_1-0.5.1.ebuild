# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Tiny, fast, modular ISO 3166-1 alpha-2/alpha-3 parser."
HOMEPAGE="
	https://github.com/moimikey/iso3166-1
	https://www.npmjs.com/package/iso3166-1
"
SRC_URI="https://registry.npmjs.org/iso3166-1/-/iso3166-1-0.5.1.tgz"
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
MYPN="${PN/_/-}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${MYPN}" || die
}
