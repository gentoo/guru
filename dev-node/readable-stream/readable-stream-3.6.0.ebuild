# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Streams3, a user-land copy of the stream library from Node.js"
HOMEPAGE="
	https://github.com/nodejs/readable-stream
	https://www.npmjs.com/package/readable-stream
"
SRC_URI="https://registry.npmjs.org/readable-stream/-/readable-stream-3.6.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/inherits
	dev-node/string_decoder
	dev-node/util-deprecate
"
