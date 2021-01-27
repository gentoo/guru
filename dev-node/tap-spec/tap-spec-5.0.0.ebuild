# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Formatted TAP output like Mocha's spec reporter"
HOMEPAGE="
	https://github.com/scottcorgan/tap-spec
	https://www.npmjs.com/package/tap-spec
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/chalk
	dev-node/duplexer
	dev-node/figures
	dev-node/lodash
	dev-node/pretty-ms
	dev-node/repeat-string
	dev-node/tap-out
	dev-node/through2
"
