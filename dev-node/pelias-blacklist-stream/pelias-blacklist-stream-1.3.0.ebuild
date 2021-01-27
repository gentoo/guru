# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Pelias document blacklist stream"
HOMEPAGE="
	https://github.com/pelias/blacklist-stream
	https://www.npmjs.com/package/pelias-blacklist-stream
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-node/pelias-config
	dev-node/through2
"
