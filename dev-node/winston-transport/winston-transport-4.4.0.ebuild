# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Base stream implementations for winston@3 and up."
HOMEPAGE="
	https://github.com/winstonjs/winston-transport
	https://www.npmjs.com/package/winston-transport
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/readable-stream
	dev-node/triple-beam
"
