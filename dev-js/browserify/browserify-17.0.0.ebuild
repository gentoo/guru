# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="browser-side require() the node way"
HOMEPAGE="
	https://github.com/browserify/browserify
	https://www.npmjs.com/package/browserify
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/JSONStream
	dev-js/assert
	dev-js/browser-pack
	dev-js/browser-resolve
	dev-js/browserify-zlib
	dev-js/buffer
	dev-js/cached-path-relative
	dev-js/concat-stream
	dev-js/console-browserify
	dev-js/constants-browserify
	dev-js/crypto-browserify
	dev-js/defined
	dev-js/deps-sort
	dev-js/domain-browser
	dev-js/duplexer2
	dev-js/events
	dev-js/glob
	dev-js/has
	dev-js/htmlescape
	dev-js/https-browserify
	dev-js/inherits
	dev-js/insert-module-globals
	dev-js/labeled-stream-splicer
	dev-js/mkdirp-classic
	dev-js/module-deps
	dev-js/os-browserify
	dev-js/parents
	dev-js/path-browserify
	dev-js/process
	dev-js/punycode
	dev-js/querystring-es3
	dev-js/read-only-stream
	dev-js/readable-stream
	dev-js/resolve
	dev-js/shasum-object
	dev-js/shell-quote
	dev-js/stream-browserify
	dev-js/stream-http
	dev-js/string_decoder
	dev-js/subarg
	dev-js/syntax-error
	dev-js/through2
	dev-js/timers-browserify
	dev-js/tty-browserify
	dev-js/url
	dev-js/util
	dev-js/vm-browserify
	dev-js/xtend
"
