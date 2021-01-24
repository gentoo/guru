# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Simplified HTTP request client."
HOMEPAGE="
	https://github.com/request/request
	https://www.npmjs.com/package/request
"
SRC_URI="https://registry.npmjs.org/request/-/request-2.88.2.tgz"
LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/aws-sign2
	dev-node/aws4
	dev-node/caseless
	dev-node/combined-stream
	dev-node/extend
	dev-node/forever-agent
	dev-node/form-data
	dev-node/har-validator
	dev-node/http-signature
	dev-node/is-typedarray
	dev-node/isstream
	dev-node/json-stringify-safe
	dev-node/mime-types
	dev-node/oauth-sign
	dev-node/performance-now
	dev-node/qs
	dev-node/safe-buffer
	dev-node/tough-cookie
	dev-node/tunnel-agent
	dev-node/uuid
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