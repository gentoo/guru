# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Packs CommonJs/AMD modules for the browser. Allows to split your codebase into multiple bundles, which can be loaded on demand. Support loaders to preprocess files, i.e. json, jsx, es7, css, less, ... and your custom stuff."
HOMEPAGE="
	https://github.com/webpack/webpack
	https://www.npmjs.com/package/webpack
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/types+eslint-scope
	dev-node/types+estree
	dev-node/webassemblyjs+ast
	dev-node/webassemblyjs+wasm-edit
	dev-node/webassemblyjs+wasm-parser
	dev-node/acorn
	dev-node/browserslist
	dev-node/chrome-trace-event
	dev-node/enhanced-resolve
	dev-node/es-module-lexer
	dev-node/eslint-scope
	dev-node/events
	dev-node/glob-to-regexp
	dev-node/graceful-fs
	dev-node/json-parse-better-errors
	dev-node/loader-runner
	dev-node/mime-types
	dev-node/neo-async
	dev-node/pkg-dir
	dev-node/schema-utils
	dev-node/tapable
	dev-node/terser-webpack-plugin
	dev-node/watchpack
	dev-node/webpack-sources
"
