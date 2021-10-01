# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="insert implicit module globals into a module-deps stream"
HOMEPAGE="
	https://github.com/browserify/insert-module-globals
	https://www.npmjs.com/package/insert-module-globals
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/JSONStream
	dev-js/acorn-node
	dev-js/combine-source-map
	dev-js/concat-stream
	dev-js/is-buffer
	dev-js/path-is-absolute
	dev-js/process
	dev-js/through2
	dev-js/undeclared-identifiers
	dev-js/xtend
"
