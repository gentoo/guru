# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="The string_decoder module from Node core"
HOMEPAGE="
	https://github.com/nodejs/string_decoder
	https://www.npmjs.com/package/string_decoder
"
SRC_URI="https://registry.npmjs.org/string_decoder/-/string_decoder-1.3.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/safe-buffer
"
