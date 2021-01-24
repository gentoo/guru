# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Streams3, a user-land copy of the stream library from Node.js"
HOMEPAGE="
	https://github.com/nodejs/readable-stream
	https://www.npmjs.com/package/readable-stream
"
SRC_URI="https://registry.npmjs.org/readable-stream/-/readable-stream-3.6.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/inherits
	dev-node/string_decoder
	dev-node/util-deprecate
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