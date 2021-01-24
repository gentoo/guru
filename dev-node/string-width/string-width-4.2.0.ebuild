# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Get the visual width of a string - the number of columns required to display it"
HOMEPAGE="
	https://github.com/sindresorhus/string-width
	https://www.npmjs.com/package/string-width
"
SRC_URI="https://registry.npmjs.org/string-width/-/string-width-4.2.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/emoji-regex
	dev-node/is-fullwidth-code-point
	dev-node/strip-ansi
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