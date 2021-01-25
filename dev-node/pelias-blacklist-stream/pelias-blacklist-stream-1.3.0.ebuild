# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Pelias document blacklist stream"
HOMEPAGE="
	https://github.com/pelias/blacklist-stream
	https://www.npmjs.com/package/pelias-blacklist-stream
"
SRC_URI="https://registry.npmjs.org/pelias-blacklist-stream/-/pelias-blacklist-stream-1.3.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/pelias-config
	dev-node/through2
"
