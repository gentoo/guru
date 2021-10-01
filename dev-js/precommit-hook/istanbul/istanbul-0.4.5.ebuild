# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Yet another JS code coverage tool"
HOMEPAGE="
	https://github.com/gotwarlost/istanbul
	https://www.npmjs.com/package/istanbul
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/abbrev
	dev-js/async
	dev-js/escodegen
	dev-js/esprima
	dev-js/glob
	dev-js/handlebars
	dev-js/js-yaml
	dev-js/mkdirp
	dev-js/nopt
	dev-js/once
	dev-js/resolve
	dev-js/supports-color
	dev-js/which
	dev-js/wordwrap
"
