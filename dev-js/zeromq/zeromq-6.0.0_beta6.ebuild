# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node flag-o-matic

MYPV="${PV/_beta/-beta.}"
MYP="${PN}-${MYPV}"
SRC_URI="mirror://npm/${PN}/-/${MYP}.tgz"
DESCRIPTION="Next-generation ZeroMQ bindings for Node.js"
HOMEPAGE="
	https://github.com/zeromq/zeromq.js
	https://www.npmjs.com/package/zeromq
"

LICENSE="MIT"
KEYWORDS="~amd64"
IUSE="drafts"

CDEPEND="net-libs/zeromq:=[drafts?]"
DEPEND="
	${NODEJS_DEPEND}
	${CDEPEND}
	dev-js/node-gyp-build
	dev-js/node-addon-api
"
RDEPEND="
	${NODEJS_RDEPEND}
	${CDEPEND}
"

src_configure() {
	NPM_FLAGS="--zmq-shared --build-from-source"
	use drafts && NPM_FLAGS+=" --zmq-draft"
	append-cxxflags " -I/usr/$(get_libdir)/node_modules/node-addon-api"
	node_src_configure
}

src_prepare() {
	rm -rf prebuilds || die
	rm -rf vendor || die
	node_src_prepare
}

src_compile() {
	node_src_compile
	rm -rf build/Release/.deps || die
	rm -rf build/Release/obj.target || die
}
