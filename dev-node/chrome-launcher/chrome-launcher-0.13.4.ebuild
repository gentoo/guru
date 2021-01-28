# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Launch latest Chrome with the Devtools Protocol port open"
HOMEPAGE="
	https://github.com/GoogleChrome/chrome-launcher
	https://www.npmjs.com/package/chrome-launcher
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/types+node
	dev-node/escape-string-regexp
	dev-node/is-wsl
	dev-node/lighthouse-logger
	dev-node/mkdirp
	dev-node/rimraf
"
