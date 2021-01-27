# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Static analysis tool for JavaScript"
HOMEPAGE="
	http://jshint.com/
	https://www.npmjs.com/package/jshint
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/cli
	dev-node/console-browserify
	dev-node/exit
	dev-node/htmlparser2
	dev-node/lodash
	dev-node/minimatch
	dev-node/shelljs
	dev-node/strip-json-comments
"
