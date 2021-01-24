# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Transform stream that allows you to run your transforms in parallel without changing the order"
HOMEPAGE="
	https://github.com/mafintosh/parallel-transform
	https://www.npmjs.com/package/parallel-transform
"
SRC_URI="https://registry.npmjs.org/parallel-transform/-/parallel-transform-1.2.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/cyclist
	dev-node/inherits
	dev-node/readable-stream
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