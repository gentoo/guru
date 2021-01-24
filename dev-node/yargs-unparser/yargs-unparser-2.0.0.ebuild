# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Converts back a yargs argv object to its original array form"
HOMEPAGE="
	https://github.com/yargs/yargs-unparser
	https://www.npmjs.com/package/yargs-unparser
"
SRC_URI="https://registry.npmjs.org/yargs-unparser/-/yargs-unparser-2.0.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/camelcase
	dev-node/decamelize
	dev-node/flat
	dev-node/is-plain-obj
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