# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="RFC6265 Cookies and Cookie Jar for node.js"
HOMEPAGE="
	https://github.com/salesforce/tough-cookie
	https://www.npmjs.com/package/tough-cookie
"
SRC_URI="https://registry.npmjs.org/tough-cookie/-/tough-cookie-4.0.0.tgz"
LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/psl
	dev-node/punycode
	dev-node/universalify
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