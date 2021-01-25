# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Base stream implementations for winston@3 and up."
HOMEPAGE="
	https://github.com/winstonjs/winston-transport
	https://www.npmjs.com/package/winston-transport
"
SRC_URI="https://registry.npmjs.org/winston-transport/-/winston-transport-4.4.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/readable-stream
	dev-node/triple-beam
"
