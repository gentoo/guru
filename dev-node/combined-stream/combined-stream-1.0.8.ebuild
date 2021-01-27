# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A stream that emits multiple other streams one after another."
HOMEPAGE="
	https://github.com/felixge/node-combined-stream
	https://www.npmjs.com/package/combined-stream
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/delayed-stream
"