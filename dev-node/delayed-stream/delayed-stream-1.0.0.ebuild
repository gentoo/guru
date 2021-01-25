# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Buffers events from a stream until you are ready to handle them."
HOMEPAGE="
	https://github.com/felixge/node-delayed-stream
	https://www.npmjs.com/package/delayed-stream
"
SRC_URI="https://registry.npmjs.org/delayed-stream/-/delayed-stream-1.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
