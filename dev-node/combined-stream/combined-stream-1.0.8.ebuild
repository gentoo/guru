# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A stream that emits multiple other streams one after another."
HOMEPAGE="
	https://github.com/felixge/node-combined-stream
	https://www.npmjs.com/package/combined-stream
"
SRC_URI="https://registry.npmjs.org/combined-stream/-/combined-stream-1.0.8.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/delayed-stream
"
