# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Yet another JS code coverage tool that computes statement, line, function and branch coverage with module loader hooks to transparently add coverage when running tests. Supports all JS coverage use cases including unit tests, server side functional tests "
HOMEPAGE="
	https://github.com/gotwarlost/istanbul
	https://www.npmjs.com/package/istanbul
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/abbrev
	dev-node/async
	dev-node/escodegen
	dev-node/esprima
	dev-node/glob
	dev-node/handlebars
	dev-node/js-yaml
	dev-node/mkdirp
	dev-node/nopt
	dev-node/once
	dev-node/resolve
	dev-node/supports-color
	dev-node/which
	dev-node/wordwrap
"
