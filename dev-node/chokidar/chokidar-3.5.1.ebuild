# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Minimal and efficient cross-platform file watching library"
HOMEPAGE="
	https://github.com/paulmillr/chokidar
	https://www.npmjs.com/package/chokidar
"
SRC_URI="https://registry.npmjs.org/chokidar/-/chokidar-3.5.1.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/anymatch
	dev-node/braces
	dev-node/glob-parent
	dev-node/is-binary-path
	dev-node/is-glob
	dev-node/normalize-path
	dev-node/readdirp
	dev-node/fsevents
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