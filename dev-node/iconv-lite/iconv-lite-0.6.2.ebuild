# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Convert character encodings in pure javascript."
HOMEPAGE="
	https://github.com/ashtuchkin/iconv-lite
	https://www.npmjs.com/package/iconv-lite
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/safer-buffer
"
