# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Module that provides a convenience wrapper around HTTP GET microservices"
HOMEPAGE="
	https://github.com/pelias/microservice-wrapper
	https://www.npmjs.com/package/pelias-microservice-wrapper
"
SRC_URI="https://registry.npmjs.org/pelias-microservice-wrapper/-/pelias-microservice-wrapper-1.9.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/lodash
	dev-node/pelias-logger
	dev-node/superagent
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