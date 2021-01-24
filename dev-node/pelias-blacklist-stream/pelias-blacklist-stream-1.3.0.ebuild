# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Pelias document blacklist stream"
HOMEPAGE="
	https://github.com/pelias/blacklist-stream
	https://www.npmjs.com/package/pelias-blacklist-stream
"
SRC_URI="https://registry.npmjs.org/pelias-blacklist-stream/-/pelias-blacklist-stream-1.3.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/pelias-config
	dev-node/through2
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