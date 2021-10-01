# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="A logger for just about everything."
HOMEPAGE="
	https://github.com/winstonjs/winston
	https://www.npmjs.com/package/winston
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/async
	dev-js/dabh+diagnostics
	dev-js/is-stream
	dev-js/logform
	dev-js/one-time
	dev-js/readable-stream
	dev-js/stack-trace
	dev-js/triple-beam
	dev-js/winston-transport
"
