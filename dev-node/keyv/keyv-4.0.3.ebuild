# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Simple key-value storage with support for multiple backends"
HOMEPAGE="
	https://github.com/lukechilds/keyv
	https://www.npmjs.com/package/keyv
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/json-buffer
"
