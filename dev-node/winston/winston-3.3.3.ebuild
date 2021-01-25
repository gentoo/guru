# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A logger for just about everything."
HOMEPAGE="
	https://github.com/winstonjs/winston
	https://www.npmjs.com/package/winston
"
SRC_URI="https://registry.npmjs.org/winston/-/winston-3.3.3.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/async
	dev-node/dabh+diagnostics
	dev-node/is-stream
	dev-node/logform
	dev-node/one-time
	dev-node/readable-stream
	dev-node/stack-trace
	dev-node/triple-beam
	dev-node/winston-transport
"
