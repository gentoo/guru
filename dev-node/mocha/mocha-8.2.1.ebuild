# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="simple, flexible, fun test framework"
HOMEPAGE="
	https://mochajs.org/
	https://www.npmjs.com/package/mocha
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/ungap+promise-all-settled
	dev-node/ansi-colors
	dev-node/browser-stdout
	dev-node/chokidar
	dev-node/debug
	dev-node/diff
	dev-node/escape-string-regexp
	dev-node/find-up
	dev-node/glob
	dev-node/growl
	dev-node/he
	dev-node/js-yaml
	dev-node/log-symbols
	dev-node/minimatch
	dev-node/ms
	dev-node/nanoid
	dev-node/serialize-javascript
	dev-node/strip-json-comments
	dev-node/supports-color
	dev-node/which
	dev-node/wide-align
	dev-node/workerpool
	dev-node/yargs
	dev-node/yargs-parser
	dev-node/yargs-unparser
"