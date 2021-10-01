# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="pack node-style source files from a json stream into a browser bundle"
HOMEPAGE="
	https://github.com/browserify/browser-pack
	https://www.npmjs.com/package/browser-pack
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/JSONStream
	dev-js/combine-source-map
	dev-js/defined
	dev-js/safe-buffer
	dev-js/through2
	dev-js/umd
"
