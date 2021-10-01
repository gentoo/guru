# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="walk the dependency graph to generate json output that can be fed into browser-pack"
HOMEPAGE="
	https://github.com/browserify/module-deps
	https://www.npmjs.com/package/module-deps
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/JSONStream
	dev-js/browser-resolve
	dev-js/cached-path-relative
	dev-js/concat-stream
	dev-js/defined
	dev-js/detective
	dev-js/duplexer2
	dev-js/inherits
	dev-js/parents
	dev-js/readable-stream
	dev-js/resolve
	dev-js/stream-combiner2
	dev-js/subarg
	dev-js/through2
	dev-js/xtend
"
