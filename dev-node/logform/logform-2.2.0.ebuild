# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="An mutable object-based log format designed for chaining & objectMode streams."
HOMEPAGE="
	https://github.com/winstonjs/logform
	https://www.npmjs.com/package/logform
"
SRC_URI="https://registry.npmjs.org/logform/-/logform-2.2.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/colors
	dev-node/fast-safe-stringify
	dev-node/fecha
	dev-node/ms
	dev-node/triple-beam
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