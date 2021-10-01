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
	dev-js/cli
	dev-js/console-browserify
	dev-js/exit
	dev-js/htmlparser2
	dev-js/lodash
	dev-js/minimatch
	dev-js/shelljs
	dev-js/strip-json-comments
"
