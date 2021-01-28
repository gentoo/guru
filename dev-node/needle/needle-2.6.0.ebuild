# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="The leanest and most handsome HTTP client in the Nodelands."
HOMEPAGE="
	https://github.com/tomas/needle
	https://www.npmjs.com/package/needle
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/debug
	dev-node/iconv-lite
	dev-node/sax
"
