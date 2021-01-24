# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="a little globber"
HOMEPAGE="
	https://github.com/isaacs/node-glob
	https://www.npmjs.com/package/glob
"
SRC_URI="https://registry.npmjs.org/glob/-/glob-7.1.6.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/fs_realpath
	dev-node/inflight
	dev-node/inherits
	dev-node/minimatch
	dev-node/once
	dev-node/path-is-absolute
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
