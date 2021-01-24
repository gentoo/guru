# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A logger for just about everything."
HOMEPAGE="
	https://github.com/winstonjs/winston
	https://www.npmjs.com/package/winston
"
SRC_URI="https://registry.npmjs.org/winston/-/winston-3.3.3.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/async
	dev-node/dabh+diagnostics
	dev-node/is-stream
	dev-node/logform
	dev-node/one-time
	dev-node/readable-stream
	dev-node/stack-trace
	dev-node/triple-beam
	dev-node/winston-transport
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
