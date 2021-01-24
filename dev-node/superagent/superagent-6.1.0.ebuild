# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="elegant & feature rich browser / node HTTP with a fluent API"
HOMEPAGE="
	https://github.com/visionmedia/superagent
	https://www.npmjs.com/package/superagent
"
SRC_URI="https://registry.npmjs.org/superagent/-/superagent-6.1.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/component-emitter
	dev-node/cookiejar
	dev-node/debug
	dev-node/fast-safe-stringify
	dev-node/form-data
	dev-node/formidable
	dev-node/methods
	dev-node/mime
	dev-node/qs
	dev-node/readable-stream
	dev-node/semver
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